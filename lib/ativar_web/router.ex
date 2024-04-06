defmodule AtivarWeb.Router do
  use AtivarWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {AtivarWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  scope "/", AtivarWeb do
    pipe_through(:browser)

    live("/", LoginLive, :index)

    live_session :default, on_mount: AtivarWeb.NavbarLive do
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
        live("/new", Index, :new)
        live("/edit/:id", Index, :edit)
        live("/profile/:id", Profile, :index)
      end

      scope "/financial", FinancialLive do
        live("/", Index, :index)
      end
    end
  end
end
