defmodule AtivarWeb.CustomersLive.Index do
  use AtivarWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    customers = [
      %{
        id: 1,
        name: "ROVEG",
        image: ~p"/images/ativar_logo.svg",
        location: "Amsterdan",
        register: "65-1011256"
      },
      %{
        id: 2,
        name: "TESTE",
        image: ~p"/images/ativar_logo.svg",
        location: "Brazil",
        register: "65-1011256"
      },
      %{
        id: 3,
        name: "TESTE",
        image: ~p"/images/ativar_logo.svg",
        location: "Brazil",
        register: "65-1011256"
      },
      %{
        id: 4,
        name: "TESTE",
        image: ~p"/images/ativar_logo.svg",
        location: "Brazil",
        register: "65-1011256"
      }
    ]

    {:ok, assign(socket, :customers, customers)}
  end
end
