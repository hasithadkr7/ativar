defmodule AtivarWeb.CustomersLive.Index do
  use AtivarWeb, :live_view

  alias Ativar.Clientes
  alias Ativar.Shared.Cliente

  @impl true
  def mount(_params, _session, socket) do
    customers = Clientes.all_order_by_desc()

    {:ok, stream(socket, :customers, customers)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end

  def handle_event("search", %{"search_customer" => search_customer}, socket) do
    filtered_customers = Clientes.get_by_name(search_customer)

    {:noreply, stream(socket, :customers, filtered_customers, reset: true)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    case Cliente.get(id) do
      {:ok, customer} ->
        socket
        |> assign(:page_title, "Editar Cliente")
        |> assign(:customer, customer)

      _ ->
        push_patch(socket, to: ~p"/customers")
    end
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Novo Cliente")
    |> assign(:customer, %Cliente{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Clientes")
    |> assign(:customer, nil)
  end
end
