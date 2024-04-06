defmodule AtivarWeb.Router do
  use AtivarWeb, :router

  import AtivarWeb.UserAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_current_user)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {AtivarWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  scope "/", AtivarWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :authenticated,
      on_mount: [AtivarWeb.NavbarLive, {AtivarWeb.UserAuth, :ensure_authenticated}] do
      live("/dashboard", DashboardLive.Index, :index)

      scope "/sales", SalesLive do
        live("/", Index, :index)
        live("/new", NewSale, :new)
        live("/edit/:id", NewSale, :edit)
        live("/invoice/:id", Invoice, :index)
        live("/os/:id", OS, :index)
        live("/:id", Detail, :index)
      end

      scope "/customers", CustomersLive do
        live("/", Index, :index)
        live("/sales/new", NewSale, :index)
        live("/profile/:id", Profile, :index)
      end

      scope "/financial", FinancialLive do
        live("/", Index, :index)
      end
    end
  end

  ## Authentication routes

  scope "/", AtivarWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live("/", LoginLive, :index)
    post "/users/login", UserSessionController, :create
  end

  scope "/", AtivarWeb do
    pipe_through [:browser]

    delete "/users/logout", UserSessionController, :delete
  end
end
