module SpockServer
    ( runServer
    )
where

import qualified Data.ByteString.Lazy.Char8    as BS

import           Web.Spock
import           Web.Spock.Config
import           Data.Semigroup                 ( (<>) )
import           Control.Monad.IO.Class         ( liftIO )
import           Control.Monad                  ( forM_ )
import           Data.Text                      ( Text )
import           Data.IORef
import           Howl

newtype ServerState = ServerState {model :: IORef BS.ByteString}
type ServerM a = SpockM () () ServerState a

runServer :: BS.ByteString -> IO ()
runServer model = do
    serverState <- ServerState <$> newIORef model
    cfg         <- defaultSpockCfg () PCNoDatabase serverState
    runSpock 7676 (spock cfg app)

app :: ServerM ()
app = do
    model'   <- getState >>= (liftIO . readIORef . model)
    response <- liftIO $ randomInstanceOf model'
    get root $ json response
