defmodule Ativar.Repo.Migrations.CreateCliente do
  use Ecto.Migration

  def change do
    create table(:cliente) do
      add :nome, :string
      add :emails, {:array, :string}
      add :telefones, {:array, :string}
      add :registro, :string
      add :acronimo, :string
      add :endereco, :string
      add :moeda, :string
      add :cor, :string
      add :observacoes, :text

      timestamps()
    end
  end
end
