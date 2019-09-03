defmodule ExGoogle.Timezone.Api do
  @moduledoc """
  API wrapper for google timezone
  """

  alias ExGoogle.Parser
  import ExGoogle.Utils

  @base_url "https://maps.googleapis.com/maps/api/timezone"

  @doc """
  Use google timezone api to find the timezone of the lat/long submitted

  Required parameters:
  - location: comma separated string of latitude and longitude
  - timestamp: time in seconds since Jan 1st, 1970 UTC to use as reference for taking
    into account any time shifts such as daylight savings time.

  Optional parameters:
  - language: desired language to show results in. [list of supported languages](https://developers.google.com/maps/faq#languagesupport)

  * [Google Maps API](https://developers.google.com/maps/documentation/timezone/intro)

  ## Examples

      alias ExGoogle.Timezone.Api, as: Timezone
      # get timezone for location
      Timezone.search(%{location: "40.714224,-73.961452", timestamp: 1513964317})

      # Advanced parameters
      Timezone.search(%{location: "40.714224,-73.961452", timestamp: 1513964317, language: "tl"})
  """
  @spec search(map) :: {:ok, binary} | {:error, binary}
  def search(params) when is_map(params) and map_size(params) > 0 do
    params
    |> Map.put(:key, api_key())
    |> build_url()
    |> HTTPoison.get(request_headers())
    |> Parser.parse()
  end

  def search(_), do: {:error, "invalid request"}

  @spec build_url(map) :: String.t()
  defp build_url(params) do
    "#{@base_url}/#{output()}?#{URI.encode_query(params)}"
  end
end
