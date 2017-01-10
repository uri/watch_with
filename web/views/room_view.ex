defmodule WatchWith.RoomView do
  use WatchWith.Web, :view

  def video_id(video_url) do
    ~r{^.*(?:youtu\.be/|\w+/|v=)(?<id>[^#&?]*)}
    |> Regex.named_captures(video_url)
    |> Access.get("id")
  end
end
