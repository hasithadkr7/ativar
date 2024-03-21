defmodule Ativar.Pagamentos.Termo do
  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  @fields ~w(valor_total moeda registro_id carregamento_id)a

  schema "termo_pagamento" do
    field :valor_total, :decimal
    field :moeda, Ecto.Enum, values: ~w[BRL USD EUR]a, default: :BRL

    has_many :parcelas, Ativar.Pagamentos.Parcela, on_replace: :delete

    belongs_to :registro, Ativar.Vendas.Registro
    belongs_to :carregamento, Ativar.Logistica.Carregamento
  end

  def changeset(termo \\ %Termo{}, attrs) do
    termo
    |> cast(attrs, @fields)
    |> cast_assoc(:parcelas, required: true)
    |> maybe_put_valor_total()
    |> foreign_key_constraint(:registro_id)
    |> foreign_key_constraint(:carregamento_id)
  end

  defp maybe_put_valor_total(%{valid?: false} = changeset), do: changeset

  defp maybe_put_valor_total(changeset) do
    parcelas = get_change(changeset, :parcelas)
    total = calculate_total_amount_from_parcelas(parcelas, Decimal.new(0))
    put_change(changeset, :valor_total, total)
  end

  defp calculate_total_amount_from_parcelas([], total), do: total

  defp calculate_total_amount_from_parcelas([parcela | rest], amount) do
    valor = get_change(parcela, :valor)
    calculate_total_amount_from_parcelas(rest, Decimal.add(amount, valor))
  end
end
