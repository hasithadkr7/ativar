defmodule AtivarWeb.CustomersLive.FormComponent do
  use AtivarWeb, :live_component

  alias Ativar.Shared.Cliente

  @impl true
  def render(assigns) do
    ~H"""
    <div class="customers-new-sale-wrapper">
      <div class="top-bar-wrapper">
        <div class="group-buttons-wrapper">
          <div class="left-group">
            <.button style="secondary" phx-click="redirect_page" phx-value-to={~p"/customers"}>
              <Lucideicons.arrow_left /> Voltar
            </.button>
          </div>
          <div class="right-group">
            <.button style="primary" name="save">
              <Lucideicons.save /> Salvar
            </.button>
          </div>
        </div>
      </div>

      <div class="customers-new-sale-title-wrapper">
        <p class="customers-new-sale-title"><%= @title %></p>
      </div>

      <.simple_form
        :let={f}
        id="customer-form"
        for={@form}
        phx-change="validate"
        phx-submit="save"
        class="customers-new-sale-details-container"
      >
        <div class="customers-new-sale-details">
          <div class="text-wrapper">Cadastro</div>
          <div class="details">
            <div class="row">
              <div class="input-data">
                <.input type="text" field={f[:nome]} errors={%{}} label="Cliente Importador" />
              </div>
              <div class="input-data">
                <.input type="text" field={f[:registro]} errors={%{}} label="Registro" />
              </div>
              <div class="input-data">
                <.input type="text" field={f[:endereco]} errors={%{}} label="Endereço" />
              </div>
              <div class="input-data">
                <.input
                  type="select"
                  field={f[:moeda]}
                  multiple={false}
                  options={[:brl, :eur, :usd]}
                  prompt="Selecione"
                  errors={%{}}
                  label="Moeda"
                />
              </div>
            </div>
            <div class="row">
              <div class="input-data emails-group">
                <.input type="text" field={f[:emails]} multiple={true} errors={%{}} label="Emails" />
              </div>
              <div class="input-data">
                <.input type="text" field={f[:telefones]} errors={%{}} label="Telefones" />
              </div>
            </div>
          </div>
        </div>

        <hr class="horizontal-divider" />

        <div class="customers-new-sale-details">
          <div class="text-wrapper">Observações Gerais</div>
          <div class="details">
            <div class="row">
              <div class="input-data">
                <.input
                  type="textarea"
                  id="cliente-importador"
                  value=""
                  name="cliente-importador"
                  errors={%{}}
                  label=""
                  placeholder="Preço FOB mais alto para acomodar custo SP. Previamente combinado com Vitor FDSA"
                />
              </div>
            </div>
          </div>
        </div>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{customer: customer} = assigns, socket) do
    changeset = Cliente.changeset(customer, %{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", params, socket) do
    params = handle_params(params)

    changeset =
      socket.assigns.customer
      |> Ecto.Changeset.change(params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", params, socket) do
    params = handle_params(params)
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp handle_params(params) do
    IO.inspect(params)
  end
end
