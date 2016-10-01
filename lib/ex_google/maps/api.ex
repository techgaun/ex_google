defmodule ExGoogle.Maps.Api do
  @moduledoc """
  Simple API wrapper for google maps
  """
  use HTTPoison.Base
  alias __MODULE__
  alias ExGoogle.Parser
  import ExGoogle.Utils

  @base_url "https://maps.googleapis.com/maps/api/geocode"
  @output "json"
  @user_agent [{"User-agent", "Brighterlink"}]
  @content_type [{"Content-Type", "application/json"}]

  @doc """
  Use google maps api to perform geocoding and reverse geocoding

  The first params map can consist of any field that google map supports.
  While the examples below show few parameters, passing any parameters that google maps api supports works.

  * [Google Maps API](https://developers.google.com/maps/documentation/geocoding/intro)

  ## Examples

      alias ExGoogle.Places.Api, as: Places
      # google maps reverse geocoding
      Api.search(%{latlng: "40.714224,-73.961452"})

      # google maps geocoding
      Api.search(%{query: "Restaurant"})

      # Advanced parameters
      Api.search(%{latlng: location, location_type: "ROOFTOP|RANGE_INTERPOLATED|GEOMETRIC_CENTER", result_type: "street_address"})
  """
  @spec search(map) :: {:ok, binary} | {:error, binary}
  def search(params) when is_map(params) and map_size(params) > 0 do
    params
    |> Map.put(:key, config[:places_api_key])
    |> build_url
    |> Api.get(request_headers)
    |> Parser.parse
  end
  def search(_), do: {:error, "invalid request"}

  @spec build_url(map) :: String.t
  def build_url(params) do
    "#{@base_url}/#{@output}?#{URI.encode_query(params)}"
  end
end
