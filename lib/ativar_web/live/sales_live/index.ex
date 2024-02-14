defmodule AtivarWeb.SalesLive.Index do
  use AtivarWeb, :live_view

  alias Ativar.Vendas

  @impl true
  def mount(_params, _session, socket) do
    sales = Vendas.list_registro()
    IO.inspect(sales)

    {:ok, stream(socket, :sales, sales)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end
end
