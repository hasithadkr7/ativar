defmodule Ativar.Repo.Migrations.CreateCarregamento do
  use Ecto.Migration

  def change do
    create table(:carregamento) do
      add :data, :date
      add :numero_pallets, :integer
      add :numero_caixas, :integer
      add :peso_bruto, :float
      add :peso_liquido, :float
      add :embalagem, :float
      add :galpao_id, references(:galpao), null: false
      add :registro_id, references(:registro), null: false

      timestamps()
    end
  end
end
