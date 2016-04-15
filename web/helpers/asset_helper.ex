defmodule PhoenixCommerce.AssetHelper do
  def upload_path(path) do
    case is_binary(path) do
      true ->
        path
        |> String.replace("priv/static/", "/")
      _ ->
        nil
    end
  end
end
