defmodule Ativar.Pagamentos.Movimentacao do
  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  schema "movimentacao" do
    field :valor, :decimal
    field :tipo, Ecto.Enum, values: ~w[entrada saida]a

    belongs_to :invoice, Ativar.Faturamento.Invoice

    timestamps()
  end

  @impl true
  def changeset(mov \\ %Movimentacao{}, attrs) do
    mov
    |> cast(attrs, [:valor, :tipo, :invoice_id])
    |> validate_required([:valor, :tipo, :invoice_id])
    |> foreign_key_constraint(:invoice_id)
  end
end
