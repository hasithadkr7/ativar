defmodule AtivarWeb.SalesLive.NewSale do
  use AtivarWeb, :live_view

  alias Ativar.Vendas.Registro
  alias Ativar.Vendas

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("validate", %{"registro" => params}, socket) do
    changeset =
      socket.assigns.sale
      |> Ecto.Changeset.change(params)
      |> Map.put(:action, :validate)

    {:norely, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"registro" => params}, socket) do
    save_sale(socket, socket.assigns.action, params)
  end

  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end

  defp save_sale(socket, :edit, sale_params) do
    case Vendas.update_registro(socket.assigns.sale, sale_params) do
      {:ok, sale} ->
        {:noreply, push_patch(socket, to: ~p"/sales/#{sale.id}")}

      {:error, changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_sale(socket, :new, sale_params) do
    case Vendas.create_registro(sale_params) do
      {:ok, sale} -> {:noreply, push_patch(socket, to: ~p"/sales/#{sale.id}")}
      {:error, changeset} -> {:noreply, assign_form(socket, changeset)}
    end
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    {:ok, sale} = Registro.get(id)

    socket
    |> assign(:page_title, "Ativar - Editar Venda")
    |> assign(:title, "Editar Venda")
    |> assign_form(sale)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Ativar - Nova Venda")
    |> assign(:title, "Nova Venda")
    |> assign_form(%Registro{})
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :sale, to_form(changeset))
  end

  defp assign_form(socket, sale) do
    changeset = Ecto.Changeset.change(sale)
    assign(socket, :sale, to_form(changeset))
  end
end
