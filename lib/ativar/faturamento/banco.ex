defmodule Ativar.Faturamento.Banco do
  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  schema "banco" do
    field :nome, :string
    field :agencia, :string
    field :swift, :string
    field :iban, :string
    field :conta, :string

    timestamps()
  end

  @impl true
  def changeset(banco \\ %Banco{}, attrs) do
    banco
    |> cast(attrs, [:nome, :agencia, :swift, :iban, :conta])
    |> validate_required([:nome, :agencia, :swift])
  end
end
