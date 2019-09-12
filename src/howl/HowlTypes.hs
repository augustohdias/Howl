{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NamedFieldPuns #-}

module HowlTypes
  ( parseConfigList
  , loadConfigs
  , Config(..)
  )
where

import qualified Data.HashMap.Strict           as HashMap

import           Data.HashMap.Strict
import           Data.Traversable
import           Data.Aeson.Types              as Types
import           Data.Text
import           Data.Either
import           Data.Scientific

type Property = [(Text, Int)]

data Config = Config {
    fieldPath :: Text,
    property :: Int }
    deriving (Show, Eq)

parseConfigList :: Value -> Parser [Config]
parseConfigList = withObject "ConfigObject" $ \obj ->
  for (HashMap.toList obj) $ \(fieldPath, prop) -> case prop of
    Number n -> return Config { fieldPath, property = getInt n }
    _        -> return Config { fieldPath, property = 1 }
  where getInt = fromIntegral . coefficient . normalize

loadConfigs :: [Config] -> HashMap Text Int
loadConfigs = HashMap.fromList . Prelude.map (\cfg -> (fieldPath cfg, property cfg))


