module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

headerView : Html msg
headerView =
 div [ class "header" ]
    [ div [ class "home-menu pure-menu pure-menu-horizontal pure-menu-fixed" ]
        [ a [ class "pure-menu-heading", href "" ]
            [ text "Random Pet Picts" ]
        , ul [ class "pure-menu-list" ]
            [ li [ class "pure-menu-item pure-menu-selected" ]
                [ a [ class "pure-menu-link", href "#" ]
                    [ text "Home" ]
                ]
            , li [ class "pure-menu-item" ]
                [ a [ class "pure-menu-link", href "#" ]
                    [ text "Tour" ]
                ]
            , li [ class "pure-menu-item" ]
                [ a [ class "pure-menu-link", href "#" ]
                    [ text "Sign Up" ]
                ]
            ]
        ]
    ]


footerView : Html msg
footerView =
    div [ class "footer l-box is-center" ] []