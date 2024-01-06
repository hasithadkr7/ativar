defmodule AtivarWeb.DashboardLive.TableComponent do
  use AtivarWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="dashboard-table">
      <h1><%= @title %></h1>

      <.table id="sales" rows={@data.sales}>
        <:col :let={{_id, sale}} label="Invoice">
          <%= String.upcase(sale.invoice) %>
        </:col>

        <:col :let={{_id, sale}} label="Cliente">
          <%= String.upcase(sale.cliente) %>
        </:col>

        <:col :let={{_id, sale}} label="Valor Negociado">
          <%= :erlang.float_to_binary(sale.valor, decimals: 2) %>
        </:col>

        <:col :let={{_id, sale}} label="Pago">
          <%= if sale.pago, do: "Sim", else: "Não" %>
        </:col>

        <:col :let={{_id, sale}} label="Status">
          <.badge color={handle_status_color(sale.status)}>
            <%= String.capitalize(Atom.to_string(sale.status)) %>
          </.badge>
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
