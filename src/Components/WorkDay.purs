module Components.WorkDay where

import Data.Date (Date)
import Prelude

import Data.Enum (pred, succ)
import Data.Maybe (Maybe(..))
import Effect.Aff (Aff)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HHE

data Action
  = SetDate Date
  | NextDay
  | PreviousDay


data Query a = HandleInput a
type Input = Date
type Message = Void
type State = Date


workDayComponent :: H.Component HH.HTML Query Input Message Aff
workDayComponent =
  H.mkComponent
  { initialState: identity
  , render: render
  , eval: H.mkEval (H.defaultEval
    { handleAction = handleAction
    , receive = (\d -> Just $ SetDate d)
    })
  }

render :: State -> H.ComponentHTML Action () Aff
render state =
  HH.div_
  [ HH.text "Events for: "
  , HH.strong_ [HH.text $ show state]
  , HH.button
    [ HHE.onClick (\_ -> Just PreviousDay)]
    [ HH.text "previous day"]
  , HH.button
    [ HHE.onClick (\_ -> Just NextDay)]
    [ HH.text "next day"]
  ]

handleAction :: forall o m. Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  SetDate date -> H.put date
  NextDay -> do
    date <- H.get
    case succ date of
      Just next -> H.put next
      Nothing -> pure unit
  PreviousDay -> do
    date <- H.get
    case pred date of
      Just prev -> H.put prev
      Nothing -> pure unit
