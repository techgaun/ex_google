defmodule ExGoogle.Places.Api do
@moduledoc """
Simple API wrapper for google maps
"""
use HTTPoison.Base
alias __MODULE__
alias ExGoogle.Parser

@base_url "https://maps.googleapis.com/maps/api/place"
@output "json"
@endpoints [details: "details", nearby: "nearbysearch", text: "textsearch"]
@supported_types [:details, :nearby, :text]
@user_agent [{"User-agent", "ExGoogle"}]
@content_type [{"Content-Type", "application/json"}]

@doc """
Use google places to search various google places data

The first params map can consist of any field that google map supports.
While the examples below show few parameters, passing any parameters that google maps api supports works.

* [Place Details](https://developers.google.com/places/web-service/details)
* [Place Search](https://developers.google.com/places/web-service/search)

## Examples

    alias ExGoogle.Places.Api, as: Places
    # place detail search
    Places.search(%{place_id: "ChIJL_zTW3FdvIcR2qmNStcaCdA"})

    # text search
    Places.search(%{query: "Restaurant"}, :text)

    # nearby search
    Places.search(%{location: "38,-94", radius: 1000}, :nearby)
"""
@spec search(map, String.t) :: {:ok, binary} | {:error, binary}
def search(params, type \\ :details) when is_map(params) and map_size(params) > 0 and type in @supported_types do
  params
  |> Map.put(:key, config[:api_key])
  |> build_url(type)
  |> Api.get(request_headers)
  |> Parser.parse
end
def search(_, _), do: {:error, "invalid request"}

@doc """
Convenience for getting nearby places by location

Example:
nearby(38.796012, -96.957633, 20)
"""
def nearby(lat, long, radius \\ 10) do
  lat_long = "#{lat},#{long}"
  result = search(%{location: lat_long, radius: radius}, :nearby)
end

@spec build_url(map, String.t) :: String.t
def build_url(params, type) do
  "#{@base_url}/#{@endpoints[type]}/#{@output}?#{URI.encode_query(params)}"
end

@spec process_response_body(binary) :: term
def process_response_body(body) do
  body
end

defp request_headers, do: @user_agent ++ @content_type
defp config, do: Application.get_env(:ex_google, :places)
end
