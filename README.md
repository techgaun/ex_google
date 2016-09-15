# ExGoogle

> Google Cloud SDK for Elixir

This is a work in progress. Currently, it supports google places API.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `ex_google` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_google, "~> 0.1.0"}]
    end
    ```

  2. Ensure `ex_google` is started before your application:

    ```elixir
    def application do
      [applications: [:ex_google]]
    end
    ```
