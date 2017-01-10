defmodule WatchWith.RoomManagerTest do
  use ExUnit.Case, async: true
  alias WatchWith.RoomManager

  setup do
    RoomManager.start_link
    :ok
  end

  @room_id "thisistheroomid"
  @video_url "https://www.youtube.com/watch?v=C5BCMQwMwM0"
  test "creates a room" do
    RoomManager.create_room(@room_id, @video_url)
    room = RoomManager.get(@room_id)
    assert room.id == @room_id
    assert room.video_url == @video_url
  end

end
