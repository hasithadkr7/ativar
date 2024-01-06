defmodule AtivarWeb.FinancialLive.FilterComponent do
  use AtivarWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, assign(socket, state: "CLOSED")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id} class="filter-wrapper">
      <div class="filter-header">
        <Lucideicons.filter /> Filtros
      </div>
      <hr class="divider" />
      <div class="filter-container">
        <div class="filter-box">
          <p>Tipo</p>
          <div class="filter-box-input1">
            <.input type="checkbox" id="type" name="type" label="Entradas" errors={%{}} />
            <.input type="checkbox" id="type" name="type" label="Saídas" errors={%{}} />
          </div>
        </div>
        <hr class="divider" />
        <div class="filter-box">
          <p>Status</p>
          <div class="filter-box-input2">
            <div class="filter-box-input1">
              <.input type="checkbox" id="status" name="status" label="Pagos" errors={%{}} />
              <.input type="checkbox" id="status" name="status" label="Vencidos" errors={%{}} />
            </div>
            <div class="filter-box-input2">
              <.input type="checkbox" id="status" name="status" label="Em atraso" errors={%{}} />
              <.input type="checkbox" id="status" name="status" label="Vencidos" errors={%{}} />
            </div>
          </div>
        </div>
        <hr class="divider" />
        <div class="filter-box">
          <p>Período</p>
          <div class="filter-box-input1">
            <.input type="checkbox" id="status" name="status" label="Pagos" errors={%{}} />
            <.input type="checkbox" id="status" name="status" label="Vencidos" errors={%{}} />
          </div>
        </div>
        <div class="filter-box">
          <p>Customizado</p>
          <div class="filter-box-container">
            <div class="filter-box-input1">
              <.input type="date" id="period" name="start-date" value="" label="" errors={%{}} />
            </div>
            <p>Até</p>
            <div class="filter-box-input2">
              <.input type="date" id="period" name="end-date" value="" label="" errors={%{}} />
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("open", _params, socket) do
    {:noreply, assign(socket, :state, "OPEN")}
  end

  @impl true
  def handle_event("close", _params, socket) do
    {:noreply, assign(socket, :state, "CLOSED")}
  end
end
