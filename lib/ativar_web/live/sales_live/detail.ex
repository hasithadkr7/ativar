defmodule AtivarWeb.SalesLive.Detail do
  use AtivarWeb, :live_view

  alias Ativar.Vendas.Registro
  alias Ativar.Repo

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    with {:ok, sale} <- Registro.get(id),
         %Registro{} = sale <-
           Repo.preload(sale, [
             :carregamento,
             :importador,
             :invoice,
             :termo,
             :transporte
           ]) do
      moeda = handle_moeda(sale.termo.moeda)

      {:ok, assign(socket, :sale, sale) |> assign(:moeda, moeda)}
    end
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end

  defp handle_moeda(moeda) do
    case moeda do
      :brl -> "R$"
      :eur -> "€"
      :usd -> "$"
      :BRL -> "R$"
      :EUR -> "€"
      :USD -> "$"
      _ -> nil
    end
  end
end
