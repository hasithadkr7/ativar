defmodule AtivarWeb.Router do
  use AtivarWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AtivarWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", AtivarWeb do
    pipe_through :browser

    live "/", LoginLive
  end
end
