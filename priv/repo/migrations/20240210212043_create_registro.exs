defmodule Ativar.Repo.Migrations.CreateRegistro do
  use Ecto.Migration

  def change do
    create table(:registro) do
      add :nota_fiscal, :string
      add :prazo_chegada, :date
      add :data_partida, :date
      add :data_chegada, :date
      add :incoterm, :string
      add :documento, :string
      add :produto, :string
      add :importador_id, references(:cliente), null: false
      add :cotacao_venda, :map
      add :cotacao_recebimento, :map

      timestamps()
    end
  end
end
