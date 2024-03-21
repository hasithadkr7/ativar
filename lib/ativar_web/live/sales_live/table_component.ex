defmodule AtivarWeb.SalesLive.TableComponent do
  use AtivarWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="sales-table-wrapper">
      <.table id="sales" rows={@data.sales}>
        <:col :let={{_id, sale}} label="Invoice">
          <span :if={sale.invoice}>
            <%= String.upcase(sale.invoice.codigo) %>
          </span>
          <span :if={!sale.invoice}>Não emitida</span>
        </:col>

        <:col :let={{_id, sale}} label="Cliente">
          <%= String.capitalize(sale.importador.nome) %>
        </:col>

        <:col :let={{_id, sale}} label="Produto">
          <%= String.capitalize(Atom.to_string(sale.produto)) %>
        </:col>

        <:col :let={{_id, sale}} label="Incoterm">
          <%= sale.incoterm %>
        </:col>

        <:col :let={{_id, sale}} label="QTD">
          <%= sale.carregamento.numero_pallets %>P/<%= sale.carregamento.numero_caixas %>C
        </:col>

        <:col :let={{_id, sale}} label="Data de Chegada">
          <%= sale.data_chegada %>
        </:col>

        <:col :let={{_id, sale}} label="Transporte">
          <%= String.capitalize(Atom.to_string(sale.transporte.tipo)) %>
        </:col>

        <:col :let={{_id, sale}} label="Valor Total">
          <%= get_currency_symbol(sale.cotacao_venda) %> <%= sale.termo.valor_total %>
        </:col>

        <:col :let={{_id, sale}} label="Status">
          <.badge color={handle_status_color(:pendente)}>
            <%= String.capitalize(Atom.to_string(:pendente)) %>
          </.badge>
        </:col>

        <:col :let={{_id, sale}} label="Mais">
          <.link patch={~p"/sales/#{sale.id}"}>
            <Lucideicons.file_plus_2 />
          </.link>
        </:col>
      </.table>
    </div>
    """
  end

  defp handle_status_color(status) do
    case status do
      :pendente -> "purple"
      :paga -> "green"
      :atrasada -> "gray"
    end
  end

  defp get_status([%{status: status}]), do: status

  defp get_currency_symbol(%{moeda: moeda}) do
    case moeda do
      :BRL -> "R$"
      :USD -> "$"
      :EUR -> "€"
    end
  end
end
