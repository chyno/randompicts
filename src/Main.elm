module Main exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode
import View exposing (..)


-- MODEL
type alias Model =
  { topic : String
  , gifUrl : String
  , topics : List String
  }

main =
  Html.program
    { init = init "frogs"
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : String -> (Model, Cmd Msg)
init topic =
  ( Model topic "waiting.gif" ["dogs", "cats", "frogs"]
  , getRandomGif topic
  )

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in Debug.log ("url = " ++ url )
    Http.send NewGif (Http.get url decodeGifUrl)

selection :   String -> Html Msg
selection   txt =
  option [ value txt, onClick (NewTopic txt) ] [ text txt ]

bodyView : Model -> Html Msg
bodyView model =
  let
       fn = List.map  (\x -> selection x) model.topics 
   in
    div [ class "content" ]
      [ h2 [ class "content-head is-center" ]
          [ text  model.topic ]
      , div [ class "pure-g" ]
          [ div [ class "l-box-lrg pure-u-1 pure-u-md-2-5" ]
              [ Html.form [onSubmit MorePlease, class "pure-form pure-form" ]
                  [ fieldset []
                      [
                       select []
                        fn,
                        button [  class "pure-button" ] [ text "More Please!" ]
                      ]
                  ]
              ]
          , div [ class "l-box-lrg pure-u-1 pure-u-md-3-5" ] [ img [src model.gifUrl ][]]]
      ]
view : Model -> Html Msg
view model =   
    div []
    [headerView,bodyView model, footerView ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case Debug.log "update" msg of 
    MorePlease -> 
      (model, getRandomGif model.topic)
    NewGif (Ok newUrl) ->
      ({model | gifUrl = newUrl}, Cmd.none)
    NewGif (Err _) ->
      (model, Cmd.none) 
    NewTopic ntopic  ->
      ( {model | topic = ntopic}, getRandomGif ntopic)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

type Msg =
  MorePlease
  | NewGif (Result Http.Error String)
  | NewTopic  String

decodeGifUrl : Decode.Decoder String
decodeGifUrl =
  Decode.at ["data", "image_url"] Decode.string
   