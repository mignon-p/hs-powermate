import Control.Monad

import PowerMate

main = do
  k <- openController
  forever $ do
    e <- nextEvent k
    putStrLn (show e)
