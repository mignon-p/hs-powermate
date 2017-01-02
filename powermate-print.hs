import Control.Monad

import System.Hardware.PowerMate

main = do
  k <- openController
  forever $ do
    e <- nextEvent k
    putStrLn (show e)
