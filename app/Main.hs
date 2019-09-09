{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.Aeson                    as JSON
import qualified Data.ByteString.Lazy.Char8    as BS
import qualified Turtle
import qualified Howl
import qualified System.Environment

import           Prelude                 hiding ( FilePath, readFile )
import           Filesystem                     ( readFile )
import           Filesystem.Path.CurrentOS
import           Options.Applicative
import           Command
import           SpockServer

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
