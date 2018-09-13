port module PortSample exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


-- MAIN
main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL
type alias Model =
  { name : String
  , age : Int
  , height : Float
  , married : Bool
  }


init : () -> (Model, Cmd Msg)
init _ =
  (Model "" 0 0.0 False, Cmd.none)


-- UPDATE
type Msg
  =