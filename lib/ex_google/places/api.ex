defmodule ExGoogle.Places.Api do
  @moduledoc """
  Simple API wrapper for google places
  """
  use HTTPoison.Base
  alias __MODULE__
  alias ExGoogle.Parser
  import ExGoogle.Utils

  @base_url "https://maps.googleapis.com/maps/api/place"
  @endpoints [details: "details", nearby: "nearbysearch", text: "textsearch"]
  @supported_types [:details, :nearby, :text]

  @doc """
  Use google places to search various google places data

  The first params map can consist of any field that google places API supports.
  While the examples below show few parameters, passing any parameters that google maps api supports works.

  * [Place Details](https://developers.google.com/places/web-service/details)
  * [Place Search](https://developers.google.com/places/web-service/search)

  ## Examples

      alias ExGoogle.Places.Api, as: Places
      # place detail search
      Places.search(%{placeid: "ChIJL_zTW3FdvIcR2qmNStcaCdA"})

      # text search
      Places.search(%{query: "Restaurant"}, :text)

      # nearby search
      Places.search(%{location: "38,-94", radius: 1000}, :nearby)
  """
  @spec search(map, String.t) :: {:ok, binary} | {:error, binary}
  def search(params, type \\ :details)
  def search(params, type) when is_map(params) and map_size(params) > 0 and type in @supported_types do
    params
    |> Map.put(:key, api_key())
    |> build_url(type)
    |> Api.get(request_headers())
    |> Parser.parse
  end
  def search(_, _), do: {:error, "invalid request"}

  @doc """
  Convenience for getting nearby places by location

  ## Examples
      ExGoogle.Places.Api.nearby(38.796012, -96.957633, 20)
  """
  def nearby(lat, long, radius \\ 10) do
    lat_long = "#{lat},#{long}"
    search(%{location: lat_long, radius: radius}, :nearby)
  end

  @doc """
  Filter given data list to only include particular keys in each item of a list
  """
  # FIXME: Move this to some convenience helper
  def filter_data(datalist, items \\ ["name", "id", "place_id", "vicinity", "types"]) do
    case datalist do
      {:ok, places} ->
        places
        |> Enum.map(fn x ->
          Map.take(x, items)
        end)
      _ ->
        []
    end
  end

  @spec build_url(map, String.t) :: String.t
  def build_url(params, type) do
    "#{@base_url}/#{@endpoints[type]}/#{output()}?#{URI.encode_query(params)}"
  end
end
