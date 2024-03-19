defmodule AtivarWeb.DashboardLive.Index do
  use AtivarWeb, :live_view

  alias Ativar.Vendas.Registro
  alias Ativar.Faturamento.Invoice
  alias Ativar.Repo

  @impl true
  def mount(_params, _session, socket) do
    latest_sales =
      Registro.all()
      |> Repo.preload([:invoice, :importador])
      |> Enum.take(-4)

    latest_invoices =
      Invoice.all()
      |> Repo.preload(:pagador)
      |> Enum.take(-4)

    invoices_count = Invoice.all() |> Enum.count()

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
