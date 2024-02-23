defmodule AtivarWeb.RouteAssigns do
  use AtivarWeb, :live_view

  alias AtivarWeb.Router.Helpers, as: Routes

  def on_mount(:default, _params, _session, socket) do
    socket =
      assign(socket,
        menus: [
          {"Geral", Routes.dashboard_index_path(socket, :index)},
          {"Vendas", Routes.sales_index_path(socket, :index)}
        ]
      )

    {:cont, attach_hook(socket, :set_menu_path, :handle_params, &manage_active_tabs/3)}
  end

  defp manage_active_tabs(_params, url, socket) do
    {:cont, assign(socket, current_path: URI.parse(url).path)}
  end
end
