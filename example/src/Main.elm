port module Main exposing (..)

import Browser
import GoogleSignIn
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Json.Encode as E



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
    
    
id : GoogleSignIn.ClientId
id = GoogleSignIn.Id "789723491626-6p01agh94gidiaesvev5saq6c6a30fmn"
   

-- Send to JS
port googleSignOut : E.Value -> Cmd msg


-- Receive from JS
port googleSignOutComplete : (E.Value -> msg) -> Sub msg
port googleSignIn : (E.Value -> msg) -> Sub msg
   
   
   
-- MODEL
type alias Model =
    Maybe String
  
  
init : () -> ( Model, Cmd msg )
init () = ( Nothing, Cmd.none )
 
 
 
-- UPDATE
 
 
type Msg
    = SignIn GoogleSignIn.Profile
    | BeginSignOut
    | SignOutComplete
   
   
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SignIn profile ->
            ( Just profile.name, Cmd.none )
        BeginSignOut ->
            ( model, googleSignOut <| GoogleSignIn.encodeId id )
        SignOutComplete ->
            ( Nothing, Cmd.none )
  
  
  
-- SUBSCRIPTIONS
  
subscriptions : Model -> Sub Msg
subscriptions model =
     Sub.batch
        [ googleSignOutComplete (\a -> SignOutComplete)
        ]
 
 
 -- VIEW
 
 
view : Model -> Html Msg
view model =
    div []
    [ case model of
        Just name ->
            div []
                [ div [] [ text ("Welcome, " ++ name) ]
                , div [] [ button [ onClick BeginSignOut ] [ text "Sign Out" ] ]
                ]
        Nothing ->
            div []
            [ text "Hello!!!"
            , GoogleSignIn.view 
                [ GoogleSignIn.onSignIn SignIn
                , GoogleSignIn.idAttr id
                ] 
            ]
    ]
    
-- type alias Profile =
--     { id : String
--     , idToken : String
--     , name : String
--     , givenName : String
--     , familyName : String
--     , imageUrl : String
--     , email : Maybe String
--     }
    
    
-- profileDecoder : Decoder Profile
-- profileDecoder =
--     Decode.map7
--         Profile
--             (Decode.field "id" Decode.string)
--             (Decode.field "idToken" Decode.string)
--             (Decode.field "name" Decode.string)
--             (Decode.field "givenName" Decode.string)
--             (Decode.field "familyName" Decode.string)
--             (Decode.field "imageUrl" Decode.string)
--             (Decode.field "email" (Decode.nullable Decode.string))
            
     