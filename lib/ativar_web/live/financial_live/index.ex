defmodule AtivarWeb.FinancialLive.Index do
  use AtivarWeb, :live_view

  alias Ativar.Faturamento.Invoice
  alias Ativar.Invoices
  alias Ativar.Repo

  @impl true
  def mount(_params, _session, socket) do
    invoices = Invoice.all() |> Repo.preload([:pagador, :registro])

    {:ok, stream(socket, :invoices, invoices)}
  end

  @impl true
  def handle_event("search", %{"search_financial" => search_financial}, socket) do
    filtered_financials = Invoices.get_by_code(search_financial)

    {:noreply, stream(socket, :invoices, filtered_financials, reset: true)}
  end
end
