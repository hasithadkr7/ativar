defmodule AtivarWeb.DashboardLive.TopMenuComponent do
  @moduledoc false

  use AtivarWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="top-menu">
      <div class="first-group">
        <div class="os">
          <span class="label">OS</span> <%= @os_count %>
        </div>
        <hr />
        <div class="rv">
          <span class="label">RV</span> <%= @rv_count %>
        </div>
        <hr />
        <div class="invoices">
          <span class="label">Invoices</span> <%= @invoices_count %>
        </div>
      </div>

      <hr />

      <div class="second-group">
        <div class="dolar">
          <span class="label">Dólar</span>
          <div class="money">
            <span>R$ 4,91</span>
            <.badge color="green"><Lucideicons.arrow_up_right />3%</.badge>
          </div>
        </div>
        <hr />
        <div class="euro">
          <span class="label">Euro</span> R$ 3,56
        </div>
      </div>
    </div>
    """
  end
end
