defmodule AtivarWeb.SalesLive.Index do
  use AtivarWeb, :live_view

  alias Ativar.Vendas

  def mount(_params, _session, socket) do
    sales = Vendas.list_registro()

    data = [
      %{
        id: 1,
        invoice: "atv 1402023",
        customer: "ROVEG",
        product: "Fresh Ginger",
        incoterm: "FOB",
        qtd: "12P/5C",
        arrival_date: "2023-01-01",
        transport: "Maritimo",
        total_value: 168.000,
        status: :processando,
        more: "..."
      },
      %{
        id: 1,
        invoice: "atv 1402023",
        customer: "ROVEG",
        product: "Fresh Ginger",
        incoterm: "FOB",
        qtd: "12P/5C",
        arrival_date: "2023-01-01",
        transport: "Maritimo",
        total_value: 168.000,
        status: :processando,
        more: "..."
      },
      %{
        id: 1,
        invoice: "atv 1402023",
        customer: "ROVEG",
        product: "Fresh Ginger",
        incoterm: "FOB",
        qtd: "12P/5C",
        arrival_date: "2023-01-01",
        transport: "Maritimo",
        total_value: 168.000,
        status: :processando,
        more: "..."
      },
      %{
        id: 1,
        invoice: "atv 1402023",
        customer: "ROVEG",
        product: "Fresh Ginger",
        incoterm: "FOB",
        qtd: "12P/5C",
        arrival_date: "2023-01-01",
        transport: "Maritimo",
        total_value: 168.000,
        status: :processando,
        more: "..."
      }
    ]

    {:ok, stream(socket, :sales, sales)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end
end
