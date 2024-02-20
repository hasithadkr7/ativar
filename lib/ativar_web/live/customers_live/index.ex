defmodule AtivarWeb.CustomersLive.Index do
  use AtivarWeb, :live_view

  alias Ativar.Clientes

  @impl true
  def mount(_params, _session, socket) do
    customers = Clientes.all() |> Clientes.preload(:endereco)

    {:ok, assign(socket, :customers, customers)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end
end
