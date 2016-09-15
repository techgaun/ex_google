use Mix.Config

config :ex_google, :places,
  api_key: System.get_env("GMAP_API_KEY")
