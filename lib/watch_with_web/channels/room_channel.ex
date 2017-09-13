defmodule WatchWith.RoomChannel do
  use WatchWithWeb, :channel
  require Logger

  intercept ["new_state", "new_message"]

  @states %{
    -1 => "unstarted",
    0 => "ended",
    1 => "playing",
    2 => "paused",
    3 => "buffering",
    5 => "video cued"
  }


  def join("room:" <> room_id, params, socket) do
    user_id = WatchWith.Crypto.generate_unique_id("U")
    socket = assign(socket, :user_id, user_id)
    {:ok, %{user_id: user_id}, socket}
  end

  @doc """
  The state of the video was change. It was either

      2 - Paused
      1 - Played

  In both cases the channel should broadcast the state with the new time
  """
  def handle_in("state_change", %{"user_id" => user_id, "new_state" => state, "current_time" => ctime} = params, socket) when state in [1,2] do
    Logger.info "These are the params ==== #{inspect(params)}"

    # Might be nil if it's the very first time
    previous_time = socket.assigns[:current_time] || 0
    socket        = assign(socket, :current_time, ctime)
    current_time  = socket.assigns.current_time

    # Use a magic number
    if abs( previous_time - current_time )> 2  do
      broadcast! socket, "new_state", %{event_code: state, current_time: ctime, issuing_user_id: user_id}
    end

    {:noreply, socket}
  end
  def handle_in(event, params, socket) do
    Logger.info "HITTING THE WRONG one -- #{event} -- #{inspect(params)}"
    {:noreply, socket}
  end

  @doc """
  Used to add events from other clients
  """
  def handle_in("event_message", %{"msg" => message, "user_id" => user_id}, socket) do
    broadcast! socket, "new_message", %{msg: message, issuing_user_id: user_id}
  end

  def handle_out(event, msg, socket) do
    Logger.info "This is the socket's user_id #{socket.assigns.user_id} compred to #{msg.issuing_user_id}"
    unless socket.assigns.user_id == msg.issuing_user_id do
      Logger.info "Not broadcast to #{socket.assigns.user_id}"
      push socket, event, msg
    end
    {:noreply, socket}
  end
end
