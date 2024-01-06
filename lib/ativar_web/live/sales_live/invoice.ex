defmodule AtivarWeb.SalesLive.Invoice do
  use AtivarWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :invoice, %{title: "teste", customer: "teste"})}
  end
end
