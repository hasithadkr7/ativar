defmodule Ativar.Vendas.Cotacao do
  use Ativar, :schema

  embedded_schema do
    field :data, :date
    field :valor, :decimal
    field :moeda, Ecto.Enum, values: ~w[BRL USD EUR]a, default: :USD
  end

  def changeset(cotacao \\ %Cotacao{}, attrs) do
    cotacao
    |> cast(attrs, [:data, :valor, :moeda])
    |> validate_required([:data, :valor])
  end
end
