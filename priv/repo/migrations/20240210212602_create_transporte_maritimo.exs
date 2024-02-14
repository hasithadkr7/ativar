defmodule Ativar.Repo.Migrations.CreateTransporteMaritimo do
  use Ecto.Migration

  def change do
    create table(:transporte_maritimo) do
      add :reserva, :string
      add :navio, :string
      add :viagem, :string
      add :armador, :string
      add :frete, :decimal
      add :transporte_id, references(:transporte), null: false
    end
  end
end
