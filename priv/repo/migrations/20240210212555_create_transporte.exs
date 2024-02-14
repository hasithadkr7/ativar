defmodule Ativar.Repo.Migrations.CreateTransporte do
  use Ecto.Migration

  def change do
    create table(:transporte) do
      add :origem, :string
      add :destino, :string
      add :tipo, :string
      add :registro_id, references(:registro), null: false
    end
  end
end
