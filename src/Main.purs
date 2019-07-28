module Main where

import Prelude

import Components.WeekDay as WD
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Effect.Now (nowDate)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)

main :: Effect Unit
main = HA.runHalogenAff do
  liftEffect $ log "🍝"
  today <- liftEffect $ nowDate
  body <- HA.awaitBody
  runUI WD.weekDayComponent today body
