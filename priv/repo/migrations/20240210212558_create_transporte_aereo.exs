defmodule Ativar.Repo.Migrations.CreateTransporteAereo do
  use Ecto.Migration

  def change do
    create table(:transporte_aereo) do
      add :companhia, :string
      add :codigo_embarque_exportador, :string
      add :codigo_embarque_importador, :string
      add :transporte_id, references(:transporte), null: false
    end
  end
end
