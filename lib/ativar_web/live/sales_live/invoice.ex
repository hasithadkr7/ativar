defmodule AtivarWeb.SalesLive.Invoice do
  use AtivarWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :invoice, %{title: "teste", customer: "teste"})}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end
end
