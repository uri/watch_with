defmodule WatchWithWeb.PageController do
  use WatchWithWeb, :controller

  @doc """
  This is the main action for this controller
  """
  def index(conn, _params) do
    render conn, "index.html"
  end
end
