{-# LANGUAGE NumericUnderscores #-}
module Canteen where

import Control.Concurrent
import Control.Concurrent.STM
import Control.Monad
import GHC.Conc (unsafeIOToSTM)

newtype Canteen = Canteen {
  chickens :: TVar Int
}

newCanteen :: IO Canteen
newCanteen = Canteen <$> newTVarIO 0

addChickens :: Canteen -> Int -> IO ()
addChickens (Canteen chickens) n = do
  putStrLn "Chef: ouch... make room... this dish is very hot"
  threadDelay 3_000_000
  available <- atomically $ do
    modifyTVar chickens (+ n)
    readTVar chickens
  putStrLn $ "Chef: more chickens ... " ++ show available ++ " now available..."

getChicken :: Canteen -> Int -> IO ()
getChicken (Canteen chickens) n = do
  let philName = "Phil " ++ show n
  atomically $ do
    available <- readTVar chickens
    when (available <= 0) $ do
      unsafeIOToSTM $ putStrLn $ philName ++ ": wot, no chickens? I'll WAIT..."
      retry
    writeTVar chickens (available - 1)
  putStrLn $ philName ++ ": those chickens look good... one please..."
