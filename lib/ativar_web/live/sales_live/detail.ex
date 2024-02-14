defmodule AtivarWeb.SalesLive.Detail do
  use AtivarWeb, :live_view

  alias Ativar.Vendas

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok, sale} = Vendas.retrieve_registro(id)

    IO.inspect(sale)
    {:ok, assign(socket, :sale, sale)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end
end
