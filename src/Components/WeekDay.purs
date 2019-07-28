module Components.WeekDay where

import Data.Date
import Data.Date.Component
import Data.Maybe (Maybe(..))
import Prelude

import Effect.Aff (Aff)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HHE

data Action = SetDate Date

data Query a = HandleInput a
type Input = Date
type Message = Void
type State = Date


weekDayComponent :: H.Component HH.HTML Query Input Message Aff
weekDayComponent =
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
  ]

handleAction :: forall o m. Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  SetDate date -> H.put date
