defmodule AtivarWeb.SalesLive.TableComponent do
  use AtivarWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="sales-table">
      <.table id="sales" rows={@data.sales}>
        <:col :let={{_id, sale}} label="Invoice">
          <%= String.upcase(sale.invoice) %>
        </:col>

        <:col :let={{_id, sale}} label="Cliente">
          <%= String.upcase(sale.customer) %>
        </:col>

        <:col :let={{_id, sale}} label="Produto">
          <%= String.upcase(sale.product) %>
        </:col>

        <:col :let={{_id, sale}} label="Incoterm">
          <%= String.upcase(sale.incoterm) %>
        </:col>

        <:col :let={{_id, sale}} label="QTD">
          <%= String.upcase(sale.qtd) %>
        </:col>

        <:col :let={{_id, sale}} label="Data de Chegada">
          <%= sale.arrival_date %>
        </:col>

        <:col :let={{_id, sale}} label="Transporte">
          <%= sale.transport %>
        </:col>

        <:col :let={{_id, sale}} label="Valor Total">
          <%= :erlang.float_to_binary(sale.total_value, decimals: 2) %>
        </:col>

        <:col :let={{_id, sale}} label="Status">
          <.badge color={handle_status_color(sale.status)}>
            <%= String.capitalize(Atom.to_string(sale.status)) %>
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
      :pago -> "green"
      :atrasado -> "gray"
      :processando -> "purple"
      :vencido -> "red"
      :concluido -> "green"
    end
  end
end
