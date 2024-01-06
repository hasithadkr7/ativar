defmodule AtivarWeb.CustomersLive.CustomerCardComponent do
  use AtivarWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="customer-card-wrapper">
      <div class="customer-profile">
        <img src={@customer.image} />
        <p><%= @customer.name %></p>
      </div>

      <div class="block-text-wrapper">
        <div class="group-text-wrapper">
          <div class="text-wrapper-1">Location</div>
          <div class="text-wrapper-2"><%= @customer.location %></div>
        </div>
        <hr class="vertical-divider" />
        <div class="group-text-wrapper">
          <div class="text-wrapper-1">Registro</div>
          <div class="text-wrapper-2"><%= @customer.register %></div>
        </div>
      </div>
    </div>
    """
  end
end
