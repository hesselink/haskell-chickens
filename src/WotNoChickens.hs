module WotNoChickens
    ( run
    ) where

import Control.Monad
import System.IO

import Canteen
import Chef
import Phil

run :: IO ()
run = do
  hSetBuffering stdout LineBuffering
  canteen <- newCanteen
  startNewChef canteen
  forM_ [0..4] (startNewPhil canteen)
