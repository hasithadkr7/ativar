defmodule AtivarWeb.FinancialLive.SideMenuComponent do
  use AtivarWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="side-menu">
      <.button style="primary" class="btn-new-sale">
        <Lucideicons.plus_square /> Adicionar Entrada
      </.button>

      <.button style="primary" class="btn-new-sale">
        <Lucideicons.minus_square /> Adicionar Saída
      </.button>

      <div class="income-card">
        <p class="title">Entradas</p>

        <div class="money">
          <span>+ R$</span>
          <p>145.642,38</p>
        </div>

        <hr class="divider" />

        <div class="stats text-green">
          <span><Lucideicons.arrow_up_right /> 3%</span>
          <p>Comparado ao mês anterior</p>
        </div>
      </div>

      <div class="expense-card">
        <p class="title">Saídas</p>

        <div class="money">
          <span>- R$</span>
          <p>145.642,38</p>
        </div>

        <hr class="divider" />

        <div class="stats text-red">
          <span><Lucideicons.arrow_down_right /> 8%</span>
          <p>Comparado ao mês anterior</p>
        </div>
      </div>
    </div>
    """
  end
end
