{-# LANGUAGE NumericUnderscores #-}
module Chef where

import Control.Concurrent
import Control.Monad

import Canteen

startNewChef :: Canteen -> IO ()
startNewChef canteen = do
  putStrLn "Chef: starting"
  void $ forkIO $ forever $ do
    putStrLn "Chef: cooking..."
    threadDelay 2_000_000
    putStrLn "Chef: 4 chickens, ready-to-go..."
    addChickens canteen 4

