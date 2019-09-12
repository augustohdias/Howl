{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy.Char8    as BS

import           Howl
import           HowlTypes
import           Data.Aeson
import           Data.Aeson.Types              as Types
import           Control.Monad
import           Data.Maybe

main :: IO ()
main = do
  putStrLn "\n-- parseConfigTest --"
  run configParsingTest
 where
  run test = do
    result <- test
    if result then putStrLn "Test succeded." else fail "Test failed."

configParsingTest :: IO Bool
configParsingTest = do
  testFile <- BS.readFile "./test/test.json"
  let results = getConfigList $ fromJust $ decode testFile
  print results
  return $ results == expectedConfig

 where
  expectedConfig :: [Config]
  expectedConfig = [Config { fieldPath = "data", property = 3 }]

  getConfigList :: Object -> [Config]
  getConfigList a =
    fromJust $ parseMaybe parseConfigList $ fromJust $ getConfig a
