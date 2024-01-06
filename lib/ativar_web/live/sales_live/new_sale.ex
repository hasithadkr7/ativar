defmodule AtivarWeb.SalesLive.NewSale do
  use AtivarWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:new_sale, %{title: "teste", customer: "teste"})
     |> assign(:changeset, %{})}
  end
end
