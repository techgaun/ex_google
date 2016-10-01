use Mix.Config

config :ex_google, api_key: System.get_env("GOOGLE_API_KEY"),
                   output: "json"
