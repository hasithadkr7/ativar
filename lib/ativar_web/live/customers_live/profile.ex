defmodule AtivarWeb.CustomersLive.Profile do
  use AtivarWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :profile, %{title: "teste", customer: "teste"})}
  end
end
