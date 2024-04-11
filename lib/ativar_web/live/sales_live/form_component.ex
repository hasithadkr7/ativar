defmodule AtivarWeb.SalesLive.FormComponent do
  use AtivarWeb, :live_component

  alias Ativar.Vendas
  alias Ativar.Vendas.Registro

  @impl true
  def render(assigns) do
    ~H"""
    <div class="new-sale-wrapper">
      <.form :let={f} for={@form} phx-target={@myself} phx-change="validate" phx-submit="save">
        <div class="top-bar-wrapper">
          <div class="group-buttons-wrapper">
            <div class="left-group">
              <.button style="secondary" phx-click="redirect_page" phx-value-to={~p"/sales"}>
                <Lucideicons.arrow_left /> Voltar
              </.button>
            </div>
            <div class="right-group">
              <.button style="primary" name="save" submit>
                <Lucideicons.save /> Gerar Venda
              </.button>
            </div>
          </div>
        </div>

        <div class="new-sale-title-wrapper">
          <p class="new-sale-title"><%= @title %></p>
        </div>

        <div class="new-sale-details-container">
          <div class="new-sale-details">
            <div class="text-wrapper">Cadastro</div>
            <div class="details">
              <div class="row">
                <div class="input-data">
                  <.input
                    type="text"
                    field={@sale[:cliente_importador]}
                    errors={%{}}
                    label="Cliente Importador"
                  />
                </div>
                <div class="input-data">
                  <.input type="text" field={@sale[:produto]} errors={%{}} label="Produto" />
                </div>
                <div class="input-data">
                  <.input type="text" field={@sale[:quantidade]} errors={%{}} label="Quantidade" />
                </div>
                <div class="input-data">
                  <.input type="text" field={@sale[:incoterm]} errors={%{}} label="Incoterm" />
                </div>
              </div>
              <div class="row">
                <div class="input-data">
                  <.input
                    type="text"
                    field={@sale[:documento_exportador]}
                    errors={%{}}
                    label="Documentos ao Exportador"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="text"
                    field={@sale[:termo_pagamento]}
                    errors={%{}}
                    label="Termos de Pagamento"
                  />
                </div>
              </div>
            </div>
          </div>

          <hr class="horizontal-divider" />

          <div class="new-sale-details">
            <div class="text-wrapper">Valores</div>
            <div class="details">
              <div class="row">
                <div class="input-data">
                  <.input type="text" field={@sale[:moeda]} errors={%{}} label="Moeda" />
                </div>
                <div class="input-data">
                  <.input type="text" field={@sale[:cotacao]} errors={%{}} label="Cotação" />
                </div>
                <div class="input-data">
                  <.input
                    type="text"
                    field={@sale[:preco_caixa]}
                    errors={%{}}
                    label="Preço por Caixa"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="text"
                    field={@sale[:valor_negociado]}
                    errors={%{}}
                    label="Valor Negociado"
                  />
                </div>
              </div>
            </div>
          </div>

          <hr class="horizontal-divider" />

          <div class="new-sale-details">
            <div class="text-wrapper">Envio</div>
            <div class="details">
              <div class="row">
                <div class="input-data">
                  <.input type="text" field={@sale[:destino]} errors={%{}} label="Destino" />
                </div>
                <div class="input-data">
                  <.input
                    type="text"
                    field={@sale[:transporte_value]}
                    errors={%{}}
                    label="Transporte"
                  />
                </div>
                <div class="input-data">
                  <.input type="text" field={@sale[:embalagem]} errors={%{}} label="Embalagem" />
                </div>
              </div>
              <div class="row">
                <div class="input-data">
                  <.input
                    type="select"
                    field={@sale[:aeroporto]}
                    multiple={false}
                    prompt="Selecione"
                    options={[1, 2, 3]}
                    errors={%{}}
                    label="Aeroporto/Porto de Origem"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="text"
                    field={@sale[:cia_frete_exportacao]}
                    errors={%{}}
                    label="Cia de Frete e Exportação"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="select"
                    field={@sale[:agente_carga]}
                    multiple={false}
                    prompt="Selecione"
                    options={[1, 2, 3]}
                    errors={%{}}
                    label="Agente de Carga"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="select"
                    field={@sale[:frete]}
                    multiple={false}
                    prompt="Selecione"
                    options={[1, 2, 3]}
                    errors={%{}}
                    label="Frete"
                  />
                </div>
              </div>
            </div>
          </div>

          <hr class="horizontal-divider" />

          <div class="new-sale-details">
            <div class="text-wrapper">Prazos</div>
            <div class="details">
              <div class="row">
                <div class="input-data">
                  <.input
                    type="date"
                    field={@sale[:data_partida]}
                    errors={%{}}
                    label="Data de Partida"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="date"
                    field={@sale[:chegada_aeroporto]}
                    errors={%{}}
                    label="Chegada Porto/Aeroporto"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="date"
                    field={@sale[:data_chegada_destino]}
                    errors={%{}}
                    label="Data de Chegada Destino"
                  />
                </div>
              </div>
            </div>
          </div>

          <hr class="horizontal-divider" />

          <div class="new-sale-details">
            <div class="text-wrapper">Pagamento</div>
            <div class="details">
              <div class="row">
                <div class="input-data">
                  <.input
                    type="text"
                    id="cliente-importador"
                    value=""
                    name="cliente-importador"
                    errors={%{}}
                    label="Descrição do Termo"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="text"
                    id="cliente-importador"
                    value=""
                    name="cliente-importador"
                    errors={%{}}
                    label="Valor Total"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="select"
                    field={@sale[:numero_parcelas]}
                    multiple={false}
                    prompt="Selecione"
                    options={[1, 2, 3]}
                    errors={%{}}
                    label="Número de Parcelas"
                  />
                </div>
              </div>
            </div>
          </div>

          <div class="new-sale-details">
            <div class="text-wrapper">Descrições das Parcelas</div>
            <div class="details">
              <div class="row">
                <div class="input-data">
                  <.input
                    type="text"
                    field={@sale[:valor_parcela]}
                    errors={%{}}
                    label="Valor da Parcela 1"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="text"
                    field={@sale[:porcentagem_parcela]}
                    errors={%{}}
                    label="Porcentagem da Parcela"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="date"
                    field={@sale[:data_vencimento]}
                    errors={%{}}
                    label="Data de Vencimento"
                  />
                </div>
              </div>
            </div>
          </div>

          <hr class="horizontal-divider" />

          <div class="new-sale-details">
            <div class="text-wrapper">Observações Gerais</div>
            <div class="details">
              <div class="row">
                <div class="input-data">
                  <.input type="textarea" field={@sale[:observacoes_gerais]} errors={%{}} label="" />
                </div>
              </div>
            </div>
          </div>
        </div>
      </.form>
    </div>
    """
  end

  @impl true
  def update(%{sale: sale} = assigns, socket) do
    changeset = Registro.changeset(sale, %{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"registro" => sale_params}, socket) do
    changeset =
      socket.assigns.customer
      |> Registro.changeset(sale_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"registro" => sale_params}, socket) do
    case Vendas.upsert_registro(socket.assigns.customer, sale_params) do
      {:ok, _sale} ->
        {:noreply,
         socket
         |> put_flash(:success, "Venda salvo com sucesso!")
         |> redirect(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
