module Howl
    ( randomInstanceOf
    , valueMapper
    )
where

import qualified Data.ByteString.Lazy.Char8    as ByteString
import qualified Data.Aeson                    as JSON
import qualified Data.Aeson.Types              as Types
import qualified Data.Text

import           Data.Scientific                ( Scientific
                                                , scientific
                                                )
import           Control.Monad
import           System.Random

randomInstanceOf :: ByteString.ByteString -> IO JSON.Object
randomInstanceOf model = do
    let Just parsedJSON = JSON.decode model :: Maybe JSON.Object
    traverse valueMapper parsedJSON

valueMapper :: Types.Value -> IO Types.Value
valueMapper value = case value of
    Types.String _      -> Types.String . Data.Text.pack <$> randomStr
    Types.Number _      -> Types.Number <$> randomNum
    Types.Object object -> Types.Object <$> traverse valueMapper object
    Types.Array  array  -> Types.Array <$> traverse valueMapper array

randomStr :: IO String
randomStr = replicateM 10 (randomRIO ('a', 'z'))

randomNum :: IO Scientific
randomNum = do
    number <- randomRIO (1, 9) :: IO Integer
    return $ scientific number 0
