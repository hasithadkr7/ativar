defmodule AtivarWeb.CustomersLive.CustomerCardComponent do
  use AtivarWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="customer-card-wrapper">
      <div class="customer-profile">
        <img src={~p"/images/logo_16x16.svg"} />
        <p><%= @customer.nome %></p>
      </div>

      <div class="block-text-wrapper">
        <div class="group-text-wrapper">
          <div class="text-wrapper-1">Location</div>
          <div class="text-wrapper-2"><%= @customer.endereco.pais %></div>
        </div>
        <hr class="vertical-divider" />
        <div class="group-text-wrapper">
          <div class="text-wrapper-1">Registro</div>
          <div class="text-wrapper-2"><%= @customer.registro %></div>
        </div>
      </div>
    </div>
    """
  end
end
