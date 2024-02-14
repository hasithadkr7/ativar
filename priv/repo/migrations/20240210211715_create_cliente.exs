defmodule Ativar.Repo.Migrations.CreateCliente do
  use Ecto.Migration

  def change do
    create table(:cliente) do
      add :email_principal, :string
      add :email_adicionais, {:array, :string}
      add :nome, :string
      add :telefone, :string
      add :registro, :string
      add :acronimo, :string
      add :endereco_id, references(:endereco), null: false

      timestamps()
    end
  end
end
