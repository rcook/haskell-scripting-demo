module HelloWorld (main) where

import Common (getProjectDirectory, reportInfo, reportSuccess)
import System.Directory (getCurrentDirectory)
import System.Environment (getArgs)
import Text.Printf (printf)

main :: IO ()
main = do
    args <- getArgs
    cwd <- getCurrentDirectory
    projectDir <- getProjectDirectory

    reportInfo "HelloWorld.hs"
    reportInfo $ printf "Command-line arguments: %s" (show args)
    reportInfo $ printf "Working directory: %s" (show cwd)
    reportInfo $ printf "Project directory is %s" projectDir
    reportSuccess "Done"
