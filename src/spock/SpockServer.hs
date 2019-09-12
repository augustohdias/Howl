module SpockServer
  ( runServer
  )
where

import qualified Data.ByteString.Lazy.Char8    as BS
import qualified Data.Aeson                    as JSON

import           Data.Aeson.Types
import           Data.Maybe
import           Web.Spock
import           Web.Spock.Config
import           Data.Semigroup                 ( (<>) )
import           Control.Monad.IO.Class         ( liftIO )
import           Control.Monad                  ( forM_ )
import           Data.Text                      ( Text )
import           Data.IORef
import           Howl
import           HowlTypes

newtype ServerState = ServerState {rawString :: IORef BS.ByteString}
type ServerM a = SpockM () () ServerState a

runServer :: BS.ByteString -> IO ()
runServer rawString = do
  serverState <- ServerState <$> newIORef rawString
  cfg         <- defaultSpockCfg () PCNoDatabase serverState
  runSpock 7676 (spock cfg app)

app :: ServerM ()
app = do
  obj      <- decode <$> (getState >>= liftIO . readIORef . rawString)
  response <- liftIO $ randomInstanceOf (getModel obj) (getConfigList obj)
  get root $ json response
 where
  getConfigList a =
    fromJust $ parseMaybe parseConfigList $ fromJust $ getConfig a
  decode = fromJust . JSON.decode
