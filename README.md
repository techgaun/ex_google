# ExGoogle [![Build Status](https://semaphoreci.com/api/v1/samaracharya/ex_google/branches/master/badge.svg)](https://semaphoreci.com/samaracharya/ex_google)

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

You can import and use the google places and maps api as below. Also, note that you can pass any query parameter that google apis support.

### [Google Maps](https://developers.google.com/maps/documentation/geocoding/intro)

    ```elixir
    alias ExGoogle.Maps.Api, as: Maps
    # google maps reverse geocoding
    Maps.search(%{latlng: "40.714224,-73.961452"})

    # google maps geocoding
    Maps.search(%{address: "1600 Amphitheatre Parkway, Mountain View, CA"})

    # Advanced parameters
    Maps.search(%{latlng: "40.714224,-73.961452", location_type: "ROOFTOP|RANGE_INTERPOLATED|GEOMETRIC_CENTER", result_type: "street_address"})
    ```

### [Google Places](https://developers.google.com/places/web-service/)

    ```elixir
    alias ExGoogle.Places.Api, as: Places
    # place detail search
    Places.search(%{placeid: "ChIJL_zTW3FdvIcR2qmNStcaCdA"})

    # text search
    Places.search(%{query: "Restaurant"}, :text)

    # nearby search
    Places.search(%{location: "38,-94", radius: 1000}, :nearby)
    ```
