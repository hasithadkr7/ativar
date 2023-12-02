defmodule Ativar.Logistica.Carregamento do
  use Ativar, :model

  @fields ~w[data numero_pallets numero_caixas peso_bruto peso_liquido embalagem galpao_id]a

  schema "configuracao_carregamento" do
    field :data, :date
    field :numero_pallets, :integer
    field :numero_caixas, :integer
    field :peso_bruto, :float
    field :peso_liquido, :float
    field :embalagem, :float

    has_one :termo, Ativar.Pagamentos.Termo

    belongs_to :galpao, Ativar.Logistica.Galpao
  end

  def changeset(carregamento \\ %Carregamento{}, attrs) do
    carregamento
    |> cast(attrs, @fields)
    |> cast_assoc(:termo, required: true)
    |> validate_required(@fields)
    |> foreign_key_constraint(:galpao_id)
  end
end
