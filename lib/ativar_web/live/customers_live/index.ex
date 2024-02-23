defmodule AtivarWeb.CustomersLive.Index do
  use AtivarWeb, :live_view

  alias Ativar.Clientes
  alias Ativar.Shared.Cliente
  alias Ativar.Repo

  @impl true
  def mount(_params, _session, socket) do
    customers = Cliente.all() |> Repo.preload(:endereco)

    {:ok, assign(socket, :customers, customers)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end

  @impl true
  def handle_event("search", %{"search_customer" => search_customer}, socket) do
    filtered_customers = Clientes.get_by_name(search_customer)

    {:noreply, assign(socket, :customers, filtered_customers)}
  end
end
