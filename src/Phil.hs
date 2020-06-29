{-# LANGUAGE NumericUnderscores #-}
module Phil where

import Control.Concurrent
import Control.Monad

import Canteen

startNewPhil :: Canteen -> Int -> IO ()
startNewPhil canteen n = do
  let philName = "Phil " ++ show n
  putStrLn $ philName ++ ": starting"
  void $ forkIO $ forever $ do
    when (n > 0) $ threadDelay 3_000_000
    putStrLn $ philName ++ ": gotta eat..."
    getChicken canteen n
    putStrLn $ philName ++ ": mmm... that's good..."
