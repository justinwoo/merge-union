module Main where

import Prelude

import Prim.Row as Row
import Record as Rec

type TotalRow =
  ( apple :: String
  , banana :: Boolean
  , kiwi :: Int
  )

type Total = { | TotalRow }

defaultTotal :: Total
defaultTotal =
  { apple: "hi"
  , banana: false
  , kiwi: 0
  }

myFn :: forall r union
   . Row.Union r TotalRow union
  => Row.Nub union TotalRow
  => { | r }
  -> Unit
myFn inputs_ = unit
  where
    -- optional annotation:
    -- inputs :: Total
    inputs = Rec.merge inputs_ defaultTotal

-- then the usage works as expected
usage :: Unit
usage = myFn { apple: "123" }

usage' :: Unit
usage' = myFn { apple: "123", banana: true }

-- This is totally equivalent to the alternative:
myFn2 :: Total -> Unit
myFn2 inputs = unit

-- in this case, callers are expected to do the merge operation themselves
usage2 :: Unit
usage2 = myFn2 defaultTotal { apple = "123" }
