defmodule AtivarWeb.SalesLive.Detail do
  use AtivarWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    sale =
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

    {:ok, assign(socket, :sale, sale)}
  end
end
