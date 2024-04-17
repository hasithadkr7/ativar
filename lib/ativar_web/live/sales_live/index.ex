defmodule AtivarWeb.SalesLive.Index do
  use AtivarWeb, :live_view

  alias Ativar.Vendas.Registro
  alias Ativar.Repo

  @impl true
  def mount(_params, _session, socket) do
    sales =
      Repo.preload(Registro.all(), [
        :carregamento,
        :importador,
        :invoice,
        :termo,
        :transporte
      ])

    {:ok, stream(socket, :sales, sales)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    case Registro.get(id) do
      {:ok, sale} ->
        sale =
          Repo.preload(sale, [
            :carregamento,
            :importador,
            :invoice,
            :termo,
            :transporte
          ])

        socket
        |> assign(:page_title, "Editar Venda")
        |> assign(:patch, ~p"/sales/#{sale.id}")
        |> assign(:sale, sale)

      _ ->
        push_patch(socket, to: ~p"/sales")
    end
  end

  defp apply_action(socket, :new, %{"from" => "dashboard"}) do
    socket
    |> assign(:page_title, "Nova Venda")
    |> assign(:patch, ~p"/dashboard")
    |> assign(:sale, %Registro{})
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Nova Venda")
    |> assign(:patch, ~p"/sales")
    |> assign(:sale, %Registro{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Vendas")
    |> assign(:sale, nil)
  end
end
