defmodule Ativar.Pagamentos.Termo do
  use Ativar, :model

  schema "termo_pagamento" do
    field :valor_total, :decimal
    field :moeda, Ecto.Enum, values: ~w[BRL USD EUR]a, default: :BRL

    has_many :parcelas, Ativar.Pagamentos.Parcela, on_replace: :delete

    belongs_to :registro, Ativar.Vendas.Registro
    belongs_to :carregamento, Ativar.Logistica.Carregamento
  end

  def changeset(termo \\ %Termo{}, attrs) do
    termo
    |> cast(attrs, [:valor_total, :moeda])
    |> cast_assoc(:parcelas, required: true)
    |> validate_required([:valor_total])
  end
end
