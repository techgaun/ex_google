defmodule ExGoogle.Utils do
  @moduledoc false

  def user_agent, do: [{"User-agent", "ExGoogle"}]
  def content_type, do: [{"Content-Type", "application/json"}]
  def request_headers, do: user_agent() ++ content_type()
  def api_key, do: Application.get_env(:ex_google, :api_key)
  def output, do: Application.get_env(:ex_google, :output) || "json"
end
