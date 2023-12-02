defmodule Ativar.Faturamento.Banco do
  use Ativar, :model

  schema "banco" do
    field :nome, :string
    field :agencia, :string
    field :swift, :string
    field :iban, :string
    field :conta, :string
  end

  def changeset(banco \\ %Banco{}, attrs) do
    banco
    |> cast(attrs, [:nome, :agencia, :swift, :iban, :conta])
    |> validate_required([:nome, :agencia, :swift])
  end
end
