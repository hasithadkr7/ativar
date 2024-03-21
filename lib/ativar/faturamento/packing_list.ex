defmodule Ativar.Faturamento.PackingList do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ativar.Shared.Cliente
  alias Ativar.Faturamento.Invoice

  schema "packing_list" do
    field(:codigo_hs, :string)

    belongs_to(:cliente_manufaturador, Cliente)
    belongs_to(:invoice, Invoice)

    timestamps()
  end

  @doc false
  def changeset(packing_list, attrs) do
    packing_list
    |> cast(attrs, [:codigo_hs, :invoice_id, :cliente_manufaturador_id])
    |> validate_required([:codigo_hs, :invoice_id, :cliente_manufaturador_id])
    |> foreign_key_constraint(:invoice_id)
    |> foreign_key_constraint(:cliente_manufaturador_id)
  end
end
