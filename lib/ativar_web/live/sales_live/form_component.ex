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
              <.button style="secondary" phx-click="redirect_page" phx-value-to={@patch}>
                <Lucideicons.arrow_left /> Voltar
              </.button>
            </div>
            <div class="right-group">
              <.button style="primary" name="save" type="submit" disabled={@form.errors != []}>
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
                    field={f[:cliente_importador]}
                    errors={%{}}
                    label="Cliente Importador"
                  />
                </div>
                <div class="input-data">
                  <.input type="text" field={f[:produto]} errors={%{}} label="Produto" />
                </div>
                <div class="input-data">
                  <.input type="text" field={f[:quantidade]} errors={%{}} label="Quantidade" />
                </div>
                <div class="input-data">
                  <.input type="text" field={f[:incoterm]} errors={%{}} label="Incoterm" />
                </div>
              </div>
              <div class="row">
                <div class="input-data">
                  <.input
                    type="text"
                    field={f[:documento_exportador]}
                    errors={%{}}
                    label="Documentos ao Exportador"
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
                  <.input type="text" field={f[:moeda]} errors={%{}} label="Moeda" />
                </div>
                <div class="input-data">
                  <.input type="text" field={f[:cotacao]} errors={%{}} label="Cotação" />
                </div>
                <div class="input-data">
                  <.input type="text" field={f[:preco_caixa]} errors={%{}} label="Preço por Caixa" />
                </div>
                <div class="input-data">
                  <.input
                    type="text"
                    field={f[:valor_negociado]}
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
                <.inputs_for :let={t} field={f[:transporte]}>
                  <div class="input-data">
                    <.input type="text" field={t[:destino]} errors={%{}} label="Destino" />
                  </div>
                  <div class="input-data">
                    <.input type="text" field={t[:transporte_value]} errors={%{}} label="Transporte" />
                  </div>
                  <div class="input-data">
                    <.input type="text" field={t[:embalagem]} errors={%{}} label="Embalagem" />
                  </div>
                </.inputs_for>
              </div>
              <div class="row">
                <div class="input-data">
                  <.input
                    type="select"
                    field={f[:aeroporto]}
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
                    field={f[:cia_frete_exportacao]}
                    errors={%{}}
                    label="Cia de Frete e Exportação"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="select"
                    field={f[:agente_carga]}
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
                    field={f[:frete]}
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
                  <.input type="date" field={f[:data_partida]} errors={%{}} label="Data de Partida" />
                </div>
                <div class="input-data">
                  <.input
                    type="date"
                    field={f[:chegada_aeroporto]}
                    errors={%{}}
                    label="Chegada Porto/Aeroporto"
                  />
                </div>
                <div class="input-data">
                  <.input
                    type="date"
                    field={f[:data_chegada_destino]}
                    errors={%{}}
                    label="Data de Chegada Destino"
                  />
                </div>
              </div>
            </div>
          </div>

          <hr class="horizontal-divider" />

          <.inputs_for :let={termo} field={f[:termo]}>
            <div class="new-sale-details">
              <div class="text-wrapper">Pagamento</div>
              <div class="details">
                <div class="row">
                  <div class="input-data">
                    <.input
                      type="text"
                      field={termo[:descricao]}
                      errors={%{}}
                      label="Descrição do Termo"
                    />
                  </div>
                  <div class="input-data">
                    <.input type="text" field={termo[:valor_total]} errors={%{}} label="Valor Total" />
                  </div>
                  <div class="input-data">
                    <.input
                      type="select"
                      field={termo[:numero_parcelas]}
                      multiple={false}
                      prompt="Selecione"
                      options={Enum.to_list(1..20)}
                      errors={%{}}
                      label="Número de Parcelas"
                    />
                  </div>
                </div>
              </div>
            </div>

            <div :if={@form.params["termo"]["numero_parcelas"]} class="new-sale-details">
              <div class="text-wrapper">Descrições das Parcelas</div>
              <div class="details">
                <.inputs_for
                  :let={parcela}
                  field={termo[:parcelas]}
                  append={append_parcelas(@form.params["termo"]["numero_parcelas"])}
                >
                  <div class="row">
                    <div class="input-data">
                      <.input
                        type="text"
                        field={parcela[:valor]}
                        errors={%{}}
                        label="Valor da Parcela"
                      />
                    </div>
                    <div class="input-data">
                      <.input
                        type="text"
                        field={parcela[:porcentagem]}
                        errors={%{}}
                        label="Porcentagem da Parcela"
                      />
                    </div>
                    <div class="input-data">
                      <.input
                        type="date"
                        field={parcela[:data_vencimento]}
                        errors={%{}}
                        label="Data de Vencimento"
                      />
                    </div>
                    <div class="input-data">
                      <.input
                        type="text"
                        field={parcela[:comentario]}
                        errors={%{}}
                        label="Comentário"
                      />
                    </div>
                  </div>
                </.inputs_for>
              </div>
            </div>
          </.inputs_for>

          <hr class="horizontal-divider" />

          <div class="new-sale-details">
            <div class="text-wrapper">Observações Gerais</div>
            <div class="details">
              <div class="row">
                <div class="input-data">
                  <.input type="textarea" field={f[:observacoes]} errors={%{}} label="" />
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
    changeset = Registro.create_changeset(sale, %{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"registro" => sale_params}, socket) do
    changeset =
      socket.assigns.sale
      |> Registro.create_changeset(sale_params)
      |> Ecto.Changeset.put_assoc(:termo, %{
        parcelas: [%Ativar.Pagamentos.Parcela{}]
      })
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"registro" => sale_params}, socket) do
    case Vendas.upsert_registro(socket.assigns.sale, sale_params) do
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

  alias Ativar.Pagamentos.Parcela

  defp append_parcelas("0"), do: []
  defp append_parcelas("1"), do: []

  defp append_parcelas(n) do
    for _ <- 2..String.to_integer(n) do
      %Parcela{}
    end
  end
end
