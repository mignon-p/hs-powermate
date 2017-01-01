import Control.Concurrent
import Control.Monad

import PowerMate

pulse :: Knob -> Double -> IO ()
pulse k x = do
  let y = (sin x + 1) / 2
      w = round $ y * 255
  setLed k w
  threadDelay 50000
  pulse k (x + 0.1)

main = do
  k <- openController
  forkIO $ pulse k 0
  forever $ do
    e <- nextEvent k
    putStrLn (show e)
