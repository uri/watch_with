defmodule WatchWithWeb.RoomController do
  use WatchWithWeb, :controller
  alias WatchWith.RoomManager

  def index(conn, _params) do
    render conn, :index
  end

  def show(conn, %{"room_id" => room_id}) do
    # Lookup video id
    room = RoomManager.get(room_id)
    render conn, :show, room_id: room.id, video_url: room.video_url
  end

  def create(conn, %{"room" => %{"video_url" => video_url}}) do
    room_id = WatchWith.Crypto.generate_unique_id("R")
    RoomManager.create_room(room_id, video_url)
    render conn, :show, room_id: room_id, video_url: video_url
  end

end
