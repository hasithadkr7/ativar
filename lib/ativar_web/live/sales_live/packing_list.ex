defmodule AtivarWeb.SalesLive.PackingList do
  use AtivarWeb, :live_view

  alias Ativar.Vendas.Registro

  def mount(%{"id" => id}, _session, socket) do
    {:ok, sale} = Registro.get(id)

    {:ok, assign(socket, :sale, sale)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end
end
