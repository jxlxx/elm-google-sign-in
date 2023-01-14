# How To

This Elm package allows you to sign-in with Google credentials in an Elm application.

The example uses the newer Google Identity Services library, opposed to [Google Sign-In](https://developers.google.com/identity/gsi/web/guides/migration).

To use this in your own projects, you need:

1. a [Google Client ID](https://support.google.com/cloud/answer/6158849);
2. HTML for the Google button (see [Google's code generator](https://developers.google.com/identity/gsi/web/tools/configurator))r;,
3. and, some ports/flags in your `html/js` (see `example/index.html` for details).


# Running the example

To run the code in `example` all you need is `elm` and optionally, `elm-live`.

Note that you will also need to update the Google Client ID in both `example/src/Main.elm` and `example/index.html`.


## With `elm-live`:

```
cd example
elm-live src/Main.elm -- --output=elm.js
```

## Without `elm-live`:

1. Build with `elm make`

```
cd example
elm make src/Main.elm --output=elm.js
```

2. Run with `elm reactor`


# A note on Google Client IDs

If you are testing this locally, when you create your OAuth 2.0 Client ID, you must add
`http://localhost` AND `http://localhost:8000`
(or what ever port you are using) to both:

- Authorized JavaScript Origins
- Authorized redirect URIs

Otherwise, it won't work.

# Credits

Forked from: https://github.com/cedric-h/elm-google-sign-in

