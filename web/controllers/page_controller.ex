defmodule WatchWith.PageController do
  use WatchWith.Web, :controller

  @doc """
  This is the main action for this controller
  """
  def index(conn, _params) do
    render conn, "index.html"
  end
end
