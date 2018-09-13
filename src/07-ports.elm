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
  = AddName String
  | AddAge String
  | AddHeight String
  | ToJs
  | FromJs Model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    AddName name ->
      ( { model | name = name }, Cmd.none )
    AddAge age ->
      ( { model | age = getInt(age) }, Cmd.none )
    AddHeight height ->
      ( { model | height = getFloat(height) }, Cmd.none )
    ToJs ->
      ( model, elm2js model )
    FromJs newmodel ->
      ( newmodel, Cmd.none )


getInt : String -> Int
getInt str =
  case String.toInt(str) of
    Ok i -> i
    _    -> 0


getFloat : String -> Float
getFloat str =
  case String.toFloat(str) of
    Ok f -> f
    _    -> 0.0


-- OUTGOING PORT
port elm2js : Model -> (Cmd Msg)


-- IMCOMING PORT
port js2elm : (Model -> msg) -> Sub msg


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    js2elm FromJs


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder "Name", onInput AddName ] []
    , input [ placeholder "Age", onInput AddAge ] []
    , input [ placeholder "Height", onInput AddHeight ] []
    , button [ onClick ToJs ] [ text "SendToJs" ]
    , div []
        [ text model.name
        , text " - "
        , text <| (String.fromInt model.age)
        , text " - "
        , text <| (String.fromInt model.heigth)
        , text " - "
        , text <| (Debug.toString model.married)
        ]
    ]