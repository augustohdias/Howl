{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy.Char8    as BS

import           HowlConfig
import           Data.Aeson
import           Data.Aeson.Types              as Types
import           Control.Monad
import           Data.Maybe

main :: IO ()
main = do
  putStrLn "\nparseConfigTest:"
  run configParsingTest
 where
  run test = do
    result <- test
    if result then putStrLn "Test succeded." else fail "Test failed."

configParsingTest :: IO Bool
configParsingTest = do
  testFile <- BS.readFile "./test/test.json"
  let Just results =
        parseMaybe parseConfigList $ fromJust $ getConfig $ fromJust $ decode
          testFile
  return $ results == expectedConfig
 where
  expectedConfig =
    [ Config { fieldPath = "data.albums"
             , property  = [("otherNumericField", 1)]
             }
    , Config { fieldPath = "data"
             , property  = [("size", 3), ("numericField", 1)]
             }
    ]
