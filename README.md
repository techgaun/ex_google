# ExGoogle

> Google Cloud SDK for Elixir

This is a work in progress. Currently, it supports google places and maps API.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `ex_google` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_google, "~> 0.1.0"}]
    end
    ```

    Or from github (recommended for now):

    ```elixir
    def deps do
      [{:ex_google, github: "techgaun/ex_google"}]
    end
    ```

  2. Ensure `ex_google` is started before your application:

    ```elixir
    def application do
      [applications: [:ex_google]]
    end
    ```

## Configuration

  1. Configure `ex_google` using the appropriate api key and output format. Currently, only json output is supported. Other formats parser are more than welcome.

  2. Now, you can use the places and maps api.

    ```elixir
    config :ex_google, api_key: System.get_env("GOOGLE_API_KEY"),
                       output: "json"
    ```

## Usage

  1. You can import and use the google places and maps api as below:

    ```elixir
    alias ExGoogle.Maps.Api, as: Maps
    # google maps reverse geocoding
    Maps.search(%{latlng: "40.714224,-73.961452"})

    alias ExGoogle.Places.Api, as: Places
    # place detail search
    Places.search(%{placeid: "ChIJL_zTW3FdvIcR2qmNStcaCdA"})
    ```
