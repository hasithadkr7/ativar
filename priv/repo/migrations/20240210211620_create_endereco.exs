defmodule Ativar.Repo.Migrations.CreateEndereco do
  use Ecto.Migration

  def change do
    create table(:endereco) do
      add :rua, :string
      add :pais, :string
      add :estado, :string
      add :cidade, :string
      add :codigo_postal, :string
      add :numero, :string

      timestamps()
    end
  end
end
