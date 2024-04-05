defmodule Ativar.Repo.Migrations.CreateMovimentacoes do
  use Ecto.Migration

  def change do
    create table(:movimentacao) do
      add :valor, :decimal, null: false
      add :tipo, :string, null: false

      add :invoice_id, references(:invoice), null: false

      timestamps()
    end

    create index(:movimentacao, [:invoice_id])
  end
end
