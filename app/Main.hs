{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.Aeson                    as JSON
import qualified Data.ByteString.Lazy.Char8    as BS
import qualified Turtle
import qualified Howl
import qualified System.Environment
import qualified Web.Spock                     as Server
import qualified Web.Spock.Config              as Server.Config
import qualified Web.Spock.Lucid               as Server.Lucid
                                                ( lucid )

import           Prelude                 hiding ( FilePath
                                                , readFile
                                                )
import           Filesystem                     ( readFile )
import           Filesystem.Path.CurrentOS     as Path
import           Options.Applicative
import           Command
import           Data.Semigroup                 ( (<>) )
import           Control.Monad.IO.Class         ( liftIO )
import           Control.Monad                  ( forM_ )
import           Data.Text                      ( Text )
import           Data.IORef
import           Lucid

{--
    To do:
        - Configurable JSON model
        - YAML support
        - Route personalization
        - Refactor
--}

showHelpOnErrorExecParser :: ParserInfo a -> IO a
showHelpOnErrorExecParser = customExecParser (prefs showHelpOnError)

howlProgDesc = "Fakes an API at localhost:7676"
howlHeader = "Haskell Owl Fake API v0.0.1"

main :: IO ()
main = do
    command <- showHelpOnErrorExecParser $ info
        (helper <*> parseCommand)
        (fullDesc <> progDesc howlProgDesc <> header howlHeader)
    run command

run :: Command -> IO ()
run command = case command of
    CommandRead {..} -> runRead filePath

runRead :: FilePath -> IO ()
runRead filePath = do
    absolutePath <- Turtle.realpath filePath
    modelJSON    <- readFile absolutePath
    runServer $ BS.fromStrict modelJSON
    return ()

-- Daqui pra baixo ta uma zona

newtype ServerState = ServerState {model :: IORef BS.ByteString}
type ServerM a = Server.SpockM () () ServerState a

runServer :: BS.ByteString -> IO ()
runServer model = do
    serverState <- ServerState <$> newIORef model
    cfg         <- Server.Config.defaultSpockCfg ()
                                                 Server.Config.PCNoDatabase
                                                 serverState
    Server.runSpock 7676 (Server.spock cfg app)

app :: ServerM ()
app = do
    model'   <- Server.getState >>= (liftIO . readIORef . model)
    response <- liftIO $ Howl.randomInstanceOf model'
    Server.get Server.root $ Server.json response

