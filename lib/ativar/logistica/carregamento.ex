defmodule Ativar.Logistica.Carregamento do
  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  alias Ativar.Logistica.Galpao
  alias Ativar.Pagamentos.Termo
  alias Ativar.Vendas.Registro

  @fields ~w[data numero_pallets numero_caixas peso_bruto peso_liquido embalagem galpao_id registro_id]a
  @required_fields ~w[numero_pallets numero_caixas data embalagem galpao_id registro_id]a

  @peso_caixa 1.2
  @peso_pallet 25
  @peso_material 8.64

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
    |> validate_required(@required_fields)
    |> put_peso_liquido()
    |> put_peso_bruto()
    |> foreign_key_constraint(:galpao_id)
    |> foreign_key_constraint(:registro_id)
  end

  defp put_peso_liquido(%{valid?: false} = changeset), do: changeset

  defp put_peso_liquido(changeset) do
    embalagem = get_change(changeset, :embalagem)
    num_pallet = get_change(changeset, :numero_pallets)
    num_caixa = get_change(changeset, :numero_caixas)
    liquido = embalagem * (num_pallet * num_caixa)

    put_change(changeset, :peso_liquido, liquido)
  end

  defp put_peso_bruto(%{valid?: false} = changeset), do: changeset

  defp put_peso_bruto(changeset) do
    liquido = get_change(changeset, :peso_liquido)
    num_pallet = get_change(changeset, :numero_pallets)
    num_caixa = get_change(changeset, :numero_caixas)

    bruto_caixa = @peso_caixa * num_caixa
    bruto_pallet = @peso_pallet * num_pallet
    bruto_total = liquido + (bruto_caixa + bruto_pallet + @peso_material)

    put_change(changeset, :peso_bruto, bruto_total)
  end
end
