{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}

module HowlConfig
    ( parseConfigList
    , getConfig
    , Config(..)
    )
where

import qualified Data.HashMap.Strict           as HashMap

import           Data.HashMap.Strict
import           Data.Traversable
import           Data.Aeson.Types              as Types
import           Data.Text

type Property = [(Text, Int)]

data Config = Config {
    fieldPath :: Text,
    property :: Property }
    deriving (Show, Eq)

parseConfigList :: Value -> Parser [Config]
parseConfigList = withObject "ConfigObject" $ \obj ->
    for (HashMap.toList obj) $ \(fieldPath, configProp) -> do
        property <- HashMap.toList <$> parseJSON configProp
        return Config { .. }

getConfig :: Object -> Maybe Value
getConfig = HashMap.lookup "_config"