defmodule WatchWith.Crypto do
  def generate_unique_id(prefix) do
    nonce = :crypto.strong_rand_bytes(8) |> Base.encode64
    prefix <> Regex.replace(~r([=+/]), nonce, "z")
  end
end
