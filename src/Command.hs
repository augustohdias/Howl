{-# LANGUAGE OverloadedStrings #-}
module Command
    (
        Command (..),
        parseCommand
    )
where

import qualified Turtle
import qualified Data.Text                     as Text
import qualified Data.Text.Encoding            as Text.Encoding
import qualified Data.ByteString.Lazy          as B

import           Prelude                 hiding ( FilePath )
import           Filesystem.Path.CurrentOS     as Path
import           Options.Applicative
import           Control.Monad
import           Data.Traversable
import           Data.Maybe
import           Data.List
import           Data.Monoid


newtype Command = CommandRead {filePath :: FilePath}
    deriving (Show)

parseCommand :: Parser Command
parseCommand = subparser $ command "read" $ info
    (helper <*> parseReadCommand)
    (fullDesc <> progDesc "Read a JSON model.")

parseReadCommand :: Parser Command
parseReadCommand = CommandRead <$> filePathParser

filePathParser :: Parser FilePath
filePathParser =
    argument (str >>= readPath) (value "./model.json" <> metavar "FILEPATH" <> help "JSON file path.")

readPath :: String -> ReadM FilePath
readPath s = do
    let path = Path.fromText (Text.pack s)
    if Path.valid path
        then return path
        else readerError ("Path not found: " ++ (show path))

filePathToString :: FilePath -> String
filePathToString = Path.encodeString

