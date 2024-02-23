defmodule AtivarWeb.DashboardLive.Index do
  use AtivarWeb, :live_view

  alias Ativar.Vendas.Registro

  @impl true
  def mount(_params, _session, socket) do
    latest_sales = Registro.all()
    latest_invoices = 1

    invoices_count = 1

    {:ok,
     socket
     |> stream(:sales, latest_sales)
     |> stream(:invoices, latest_invoices)
     |> assign(:invoices_count, invoices_count)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end
end
