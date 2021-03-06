defmodule WatchWithWeb.Router do
  use WatchWithWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WatchWithWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/rooms", RoomController, :index
    get "/rooms/:room_id", RoomController, :show
    post "/rooms", RoomController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", WatchWith do
  #   pipe_through :api
  # end
end
