defmodule AtivarWeb.CustomersLive.Profile do
  use AtivarWeb, :live_view

  alias Ativar.Shared.Cliente

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    with {:ok, %Cliente{} = customer} <- Cliente.get(id) do
      {:ok, assign(socket, :customer, customer)}
    end
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end
end
