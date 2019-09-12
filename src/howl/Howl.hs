{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedLists #-}

module Howl
  ( randomInstanceOf
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

defaultArraySize = 5

getConfig :: Object -> Maybe Value
getConfig = H.lookup "_config"

getModel :: Object -> Object
getModel = H.delete "_config"

randomInstanceOf :: HashMap Text Value -> [Config] -> IO Object
randomInstanceOf object cfgs = traverseWithKey randomizeObject object
  where randomizeObject = randomizeValue cfgs

randomizeValue :: [Config] -> Text -> Value -> IO Value
randomizeValue cfgs key value = case value of
  String _   -> newString
  Number _   -> newNumber
  Array  arr -> do
    let listSize = H.lookupDefault defaultArraySize key $ loadConfigs cfgs
    processArray (replicateArray arr listSize)
  Object obj -> processObject obj
 where
  processArray :: Vector Value -> IO Value
  processArray array = Array <$> traverse randomizeArray array

  processObject :: Object -> IO Value
  processObject object = Object <$> traverseWithKey randomizeObject object

  randomizeObject = randomizeValue cfgs
  randomizeArray  = randomizeValue cfgs key

-- Replication boilerplate

replicateArray :: Array -> Int -> Vector Value
replicateArray array size = V.concat $ copy size $ sampleUnity array
 where
  sampleUnity = V.take 1
  copy        = Prelude.replicate

-- Randomize

newString :: IO Value
newString = String . T.pack <$> copy (randomRIO ('a', 'z'))
  where copy = Control.Monad.replicateM 10

newNumber :: IO Value
newNumber = Number . createNumber <$> randomRIO (1, 100)
  where createNumber n = scientific n 0
