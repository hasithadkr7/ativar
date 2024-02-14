defmodule Ativar.Repo.Migrations.CreateBanco do
  use Ecto.Migration

  def change do
    create table(:banco) do
      add :nome, :string
      add :agencia, :string
      add :swift, :string
      add :iban, :string
      add :conta, :string

      timestamps()
    end
  end
end
