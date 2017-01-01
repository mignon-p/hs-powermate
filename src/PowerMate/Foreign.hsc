{-# LANGUAGE CPP, ForeignFunctionInterface #-}

module PowerMate.Foreign
  ( EventSeconds
  , EventMicroseconds
  , EventType
  , EventCode
  , EventValue
  , InputEvent (..)
  ) where

import Control.Applicative
import Data.Int
import Data.Word
import Foreign.Storable

#include <linux/input.h>

type EventSeconds = #type time_t
type EventMicroseconds = #type suseconds_t
type EventType = Word16
type EventCode = Word16
type EventValue = Int32

data InputEvent =
  InputEvent
  { eventSeconds      :: EventSeconds
  , eventMicroseconds :: EventMicroseconds
  , eventType         :: EventType
  , eventCode         :: EventCode
  , eventValue        :: EventValue
  }

peekSeconds = #peek struct input_event, time.tv_sec
pokeSeconds = #poke struct input_event, time.tv_sec
peekMicroseconds = #peek struct input_event, time.tv_usec
pokeMicroseconds = #poke struct input_event, time.tv_usec
peekType = #peek struct input_event, type
pokeType = #poke struct input_event, type
peekCode = #peek struct input_event, code
pokeCode = #poke struct input_event, code
peekValue = #peek struct input_event, value
pokeValue = #poke struct input_event, value

instance Storable InputEvent where
  sizeOf _    = #size      struct input_event
  -- This generates a call to hsc_alignment, which doesn't
  -- exist in /usr/lib/ghc/template-hsc.h
  -- alignment _ = #alignment struct input_event
  alignment _ = 8 -- so, just be conservative
  peek ie = InputEvent
            <$> peekSeconds      ie
            <*> peekMicroseconds ie
            <*> peekType         ie
            <*> peekCode         ie
            <*> peekValue        ie
  poke p ie = do
    pokeSeconds      p (eventSeconds      ie)
    pokeMicroseconds p (eventMicroseconds ie)
    pokeType         p (eventType         ie)
    pokeCode         p (eventCode         ie)
    pokeValue        p (eventValue        ie)
