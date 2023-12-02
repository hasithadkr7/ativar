defmodule Ativar.Faturamento.Invoice do
  use Ativar, :model

  alias Ativar.Faturamento.Banco
  alias Ativar.Vendas.Registro
  alias Ativar.Shared.Cliente

  @relations ~w[banco_recebedor_id banco_intermediario_id notificador_id pagador_id registro_id]a

  schema "invoice" do
    field :codigo, :string

    belongs_to :banco_recebedor, Banco, on_replace: :update
    belongs_to :banco_intermediario, Banco, on_replace: :update
    belongs_to :notificador, Cliente, on_replace: :update
    belongs_to :pagador, Cliente, on_replace: :update
    belongs_to :registro, Registro, on_replace: :update
  end

  def changeset(invoice \\ %Invoice{}, attrs) do
    invoice
    |> cast(attrs, [:codigo | @relations])
    |> validate_required(@relations)
    |> foreign_key_constraint(:banco_recebedor_id)
    |> foreign_key_constraint(:banco_intermediario_id)
    |> foreign_key_constraint(:notificador_id)
    |> foreign_key_constraint(:pagador_id)
    |> foreign_key_constraint(:registro_id)
  end
end
