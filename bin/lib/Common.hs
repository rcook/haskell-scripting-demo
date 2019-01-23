{-# LANGUAGE DeriveAnyClass #-}

module Common
    ( getProjectDirectory
    , reportError
    , reportInfo
    , reportSuccess
    ) where

import Control.Exception 
    ( Exception
    , throwIO
    )
import Data.Maybe (fromMaybe)
import System.Directory
    ( doesDirectoryExist
    , doesFileExist
    , getCurrentDirectory
    )
import System.FilePath ((</>), takeDirectory)
import Text.Printf (printf)

data CommonException = CommonException String deriving Exception
instance Show CommonException where
    show (CommonException message) = message

projectName :: String
projectName = "haskell-scripting-demo"

getProjectDirectory :: IO FilePath
getProjectDirectory = do
    cwd <- getCurrentDirectory
    go cwd cwd
    where
        go cwd "/" = throwIO $ CommonException (printf "Could not find project directory containing directory %s" cwd)
        go cwd dir = do
            hasGitDir <- doesDirectoryExist (dir </> ".git")
            hasCabalFile <- doesFileExist $ dir </> projectName ++ ".cabal"
            if hasGitDir && hasCabalFile
                then pure dir
                else go cwd (takeDirectory dir)

report :: Int -> String -> String -> IO ()
report colour kind = putStrLn . printf "\x1b[1;%dm%s: %s\x1b[0m" colour kind

reportInfo :: String -> IO ()
reportInfo = report 33 "INFO"

reportSuccess :: String -> IO ()
reportSuccess = report 32 "SUCCESS"

reportError :: String -> IO ()
reportError = report 31 "ERROR"
