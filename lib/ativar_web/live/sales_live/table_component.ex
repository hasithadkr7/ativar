defmodule AtivarWeb.SalesLive.TableComponent do
  use AtivarWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="sales-table">
      <.table id="sales" rows={@data.sales}>
        <:col :let={{_id, sale}} label="Invoice">
          <%= String.upcase(sale.nota_fiscal) %>
        </:col>

        <:col :let={{_id, sale}} label="Cliente">
          <%= String.upcase(sale.importador.nome) %>
        </:col>

        <:col :let={{_id, sale}} label="Produto">
          <%= String.capitalize(Atom.to_string(sale.produto)) %>
        </:col>

        <:col :let={{_id, sale}} label="Incoterm">
          <%= sale.incoterm %>
        </:col>

        <:col :let={{_id, sale}} label="QTD">
          <%= sale.carregamento.numero_caixas %>
        </:col>

        <:col :let={{_id, sale}} label="Data de Chegada">
          <%= sale.data_chegada %>
        </:col>

        <:col :let={{_id, sale}} label="Transporte">
          <%= String.capitalize(Atom.to_string(sale.transporte.tipo)) %>
        </:col>

        <:col :let={{_id, sale}} label="Valor Total">
          <%= sale.carregamento.termo.valor_total %>
        </:col>

        <:col :let={{_id, sale}} label="Status">
          <.badge color={handle_status_color(get_status(sale.carregamento.termo.parcelas))}>
            <%= String.capitalize(Atom.to_string(get_status(sale.carregamento.termo.parcelas))) %>
          </.badge>
        </:col>

        <:col :let={{_id, _sale}} label="Mais">
          <Lucideicons.file_plus_2 />
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
end
