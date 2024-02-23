defmodule Ativar.Logistica.Carregamento do
  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  alias Ativar.Logistica.Galpao
  alias Ativar.Pagamentos.Termo
  alias Ativar.Vendas.Registro

  @fields ~w[data numero_pallets numero_caixas peso_bruto peso_liquido embalagem galpao_id registro_id]a

  schema "carregamento" do
    field :data, :date
    field :numero_pallets, :integer
    field :numero_caixas, :integer
    field :peso_bruto, :float
    field :peso_liquido, :float
    field :embalagem, :float

    has_one :termo, Termo

    belongs_to :galpao, Galpao
    belongs_to :registro, Registro

    timestamps()
  end

  @impl true
  def changeset(carregamento \\ %Carregamento{}, attrs) do
    carregamento
    |> cast(attrs, @fields)
    |> cast_assoc(:termo, required: true)
    |> validate_required(@fields)
    |> foreign_key_constraint(:galpao_id)
  end
end
