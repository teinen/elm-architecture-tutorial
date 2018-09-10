import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


-- MAIN
main =
  Browser.sandbox { init = init, view = view, update = update }


-- MODEL
type alias Model =
  { name : String
  , password : String
  , passwordConfirm : String
  }

init : Model
init =
  { name = ""
  , password = ""
  , passwordConfirm = ""
  }


-- UPDATE
type Msg
  = Name String
  | Password String
  | PasswordConfirm String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }
    Password password ->
      { model | password = password }
    PasswordConfirm passwordConfirm ->
      { model | passwordConfirm = passwordConfirm }


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordConfirm PasswordConfirm
    , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewValidation : Model -> Html msg
viewValidation model =
  if model.password == model.passwordConfirm then
    div [ style "color" "green" ] [ text "OK" ]
  else
    div [ style "color" "red" ] [ text "Passwords do not match!" ]