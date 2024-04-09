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

    # Registro.all() |> Repo.preload([:transporte, :invoice, :importador, :carregamento, :termo])

    IO.inspect(sales)

    {:ok, stream(socket, :sales, sales)}
  end

  @impl true
  def handle_event("redirect_page", %{"to" => to}, socket) do
    {:noreply, push_navigate(socket, to: to)}
  end
end
