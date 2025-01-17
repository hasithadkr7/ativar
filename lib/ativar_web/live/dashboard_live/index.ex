defmodule AtivarWeb.DashboardLive.Index do
  use AtivarWeb, :live_view

  alias Ativar.Vendas.Registro
  alias Ativar.Faturamento.Invoice
  alias Ativar.Repo
  alias Ativar.Pagamentos.Parcela
  alias Ativar.Pagamentos.Movimentacao

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
    os_count = 1
    rv_count = 1

    incomings =
      Enum.reduce(Movimentacao.all(), 0, fn movimentacao, acc ->
        Decimal.add(movimentacao.valor, acc)
      end)

    expenses =
      Enum.reduce(Movimentacao.all(), 0, fn movimentacao, acc ->
        Decimal.add(movimentacao.valor, acc)
      end)

    {:ok,
     socket
     |> stream(:sales, latest_sales)
     |> stream(:invoices, latest_invoices)
     |> assign(:os_count, os_count)
     |> assign(:rv_count, rv_count)
     |> assign(:invoices_count, invoices_count)
     |> assign(:incomings, incomings)
     |> assign(:expenses, expenses)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end
end
