defmodule ExGoogleTest do
  # todo: play around with ex_vcr
  use ExUnit.Case
  alias ExGoogle.Maps.Api, as: Maps
  alias ExGoogle.Places.Api, as: Places

  test "google maps api works correctly" do
    result = Maps.search(%{latlng: "27.5404,83.7943"})
    assert {:ok, [%{"formatted_address" => "Triveni Road, Bardaghat 33007, Nepal"} | _]} = result
  end

  test "google places details works correctly" do
    place_id = "ChIJ11Zb-A87lDkR-5Kvz6bIPtc"
    result = Places.search(%{placeid: place_id})
    assert {:ok, %{"result" => %{"formatted_address" => "Triveni Road, Bardaghat 33007, Nepal"}}} = result
  end

  test "google places search works correctly" do
    result = Places.search(%{location: "27.5404,83.7943", radius: 1000}, :nearby)
    assert {:ok, _} = result
  end
end
