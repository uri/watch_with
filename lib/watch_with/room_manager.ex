defmodule WatchWith.RoomManager do
  use GenServer

  defmodule Room do
    defstruct [:id, :video_url]
  end

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def create_room(room_id, video_url) do
    GenServer.cast(__MODULE__, {:create, room_id, video_url})
  end

  def get(room_id) do
    GenServer.call(__MODULE__, {:details, room_id})
  end

  def handle_call({:details, room_id}, _from, rooms) do
    rooms[room_id]
    {:reply, rooms[room_id], rooms}
  end

  def handle_cast({:create, room_id, video_url}, rooms) do
    room = %Room{id: room_id, video_url: video_url}
    {:noreply, Map.put(rooms, room_id, room)}
  end
end
