{-# LANGUAGE OverloadedStrings #-}

module Howl
    ( randomInstanceOf
    , valueMapper
    , getConfig
    , getModel
    )
where


import           Data.Scientific                ( Scientific
                                                , scientific
                                                )
import           Data.Aeson                    as JSON
import           Data.Text                     as T
import           Data.ByteString.Lazy.Char8    as B
import           Data.HashMap.Strict           as H
import           Data.Vector                   as V
import           Data.Aeson.Types
import           Control.Monad
import           System.Random
import           HowlTypes

getConfig :: Object -> Maybe Value
getConfig = H.lookup "_config"

getModel :: Object -> Object
getModel = H.delete "_config"

randomInstanceOf :: Object -> [Config] -> IO Object
randomInstanceOf model cfg = traverse valueMapper model

valueMapper :: Value -> IO Value
valueMapper value = case value of
    String _      -> String <$> randomStr
    Number _      -> Number <$> randomNum
    Object object -> Object <$> traverse valueMapper object
    Array  array  -> Array <$> randomArray array 10

randomArray :: Array -> Int -> IO (Vector Value)
randomArray array size = do
    let vector = V.concat $ copy size $ sample array
    traverse valueMapper vector
  where
    sample = V.take 1
    copy   = Prelude.replicate

randomStr :: IO Text
randomStr = T.pack <$> copy (randomRIO ('a', 'z'))
    where copy = Control.Monad.replicateM 10

randomNum :: IO Scientific
randomNum = createNumber <$> randomRIO (1, 100)
    where createNumber n = scientific n 0
