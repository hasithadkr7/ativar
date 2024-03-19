defmodule AtivarWeb.DashboardLive.TableComponentInvoice do
  use AtivarWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="dashboard-table">
      <h1><%= @title %></h1>

      <.table id={@id} rows={@data}>
        <:col :let={{_id, invoice}} label="Invoice">
          <%= String.upcase(invoice.codigo) %>
        </:col>

        <:col :let={{_id, invoice}} label="Cliente">
          <%= String.upcase(invoice.pagador.nome) %>
        </:col>

        <:col :let={{_id, invoice}} label="Valor Negociado">
          <%= :erlang.float_to_binary(1.00, decimals: 2) %>
        </:col>

        <:col :let={{_id, invoice}} label="Pago">
          <%= if true, do: "Sim", else: "Não" %>
        </:col>

        <:col :let={{_id, invoice}} label="Status">
          <.badge color={handle_status_color(:pago)}>
            <%= String.capitalize(Atom.to_string(:pago)) %>
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
