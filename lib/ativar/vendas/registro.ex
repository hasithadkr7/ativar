defmodule Ativar.Vendas.Registro do
  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  alias Ativar.Faturamento.Invoice
  alias Ativar.Logistica.Carregamento
  alias Ativar.Logistica.Transporte
  alias Ativar.Pagamentos.Termo
  alias Ativar.Vendas.Cotacao
  alias Ativar.Shared.Cliente

  @incoterms [:fob, :cib, :door2door]
  @documentos [:usual_com_fito, :sem_fito, :usual_usa]
  @produtos [:baby_ginger, :mature_ginger]

  @fields ~w[nota_fiscal prazo_chegada data_partida data_chegada incoterm documento produto importador_id]a
  @required_fields ~w[prazo_chegada data_partida data_chegada incoterm produto documento importador_id]a

  schema "registro" do
    field :nota_fiscal, :string
    field :prazo_chegada, :date
    field :data_partida, :date
    field :data_chegada, :date
    field :observacoes, :string

    field :incoterm, Ecto.Enum, values: @incoterms
    field :documento, Ecto.Enum, values: @documentos
    field :produto, Ecto.Enum, values: @produtos

    has_one :transporte, Transporte, on_replace: :update
    has_one :carregamento, Carregamento, on_replace: :update
    has_one :termo, Termo, on_replace: :update
    has_one :invoice, Invoice, on_replace: :update

    belongs_to :importador, Cliente, on_replace: :update

    embeds_one :cotacao_venda, Cotacao, on_replace: :update
    embeds_one :cotacao_recebimento, Cotacao, on_replace: :update

    timestamps()
  end

  @impl true
  def changeset(registro \\ %Registro{}, attrs) do
    cast(registro, attrs, @fields)
  end

  def create_changeset(registro \\ %Registro{}, attrs) do
    registro
    |> changeset(attrs)
    |> cast_assoc(:carregamento, required: true)
    |> cast_assoc(:termo, required: true)
    |> cast_embed(:cotacao_venda, required: true)
    |> cast_assoc(:transporte, required: true)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:importador_id)
  end

  def update_changeset(registro \\ %Registro{}, attrs) do
    registro
    |> changeset(attrs)
    |> cast_assoc(:carregamento, required: false)
    |> cast_assoc(:termo, required: false)
    |> cast_embed(:cotacao_venda, required: false)
  end
end
