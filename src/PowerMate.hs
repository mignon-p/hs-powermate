{-# LANGUAGE MultiWayIf #-}

module PowerMate where

import Data.Word
import System.IO

import PowerMate.Foreign

newtype Knob = Knob Handle

data Event = ButtonPressed | ButtonReleased | Clockwise | Counterclockwise
           deriving (Eq, Ord, Show, Read, Bounded, Enum)

openController :: IO Knob
openController = do
  h <- openFile "/dev/input/powermate" ReadWriteMode
  hSetBuffering h NoBuffering
  return $ Knob h

nextEvent :: Knob -> IO Event
nextEvent k@(Knob h) = do
  ie <- readEvent h
  let et = eventType ie
      ec = eventCode ie
      ev = eventValue ie
  if | et == evKey && ev == 1    -> return ButtonPressed
     | et == evKey && ev == 0    -> return ButtonReleased
     | et == evRel && ev == 1    -> return Clockwise
     | et == evRel && ev == (-1) -> return Counterclockwise
     | otherwise                 -> nextEvent k

setLed :: Knob -> Word8 -> IO ()
setLed (Knob h) v = do
  writeEvent h $ InputEvent 0 0 btnMisc mscPulseLed $ fromIntegral v

closeController :: Knob -> IO ()
closeController (Knob h) = hClose h

readEvent :: Handle -> IO InputEvent
readEvent = undefined

writeEvent :: Handle -> InputEvent -> IO ()
writeEvent = undefined
