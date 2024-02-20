defmodule AtivarWeb.DashboardLive.Index do
  use AtivarWeb, :live_view

  alias Ativar.Vendas

  def mount(_params, _session, socket) do
    sales = Vendas.list_registro()
    IO.inspect(sales)
    invoices = 1

    data = [
      %{
        id: 1,
        invoice: "atv 1402023",
        cliente: "ROVEG",
        valor: 42.50,
        pago: true,
        status: :pago
      },
      %{
        id: 2,
        invoice: "atv 6981394a",
        cliente: "schrijvershof",
        valor: 72.00,
        pago: false,
        status: :atrasado
      },
      %{
        id: 2,
        invoice: "atv 6981394a",
        cliente: "schrijvershof",
        valor: 72.00,
        pago: false,
        status: :atrasado
      },
      %{
        id: 2,
        invoice: "atv 6981394a",
        cliente: "schrijvershof",
        valor: 72.00,
        pago: false,
        status: :atrasado
      }
    ]

    {:ok, stream(socket, :sales, data)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end
end
