defmodule Ativar.Repo.Migrations.CreateInvoice do
  use Ecto.Migration

  def change do
    create table(:invoice) do
      add :codigo, :string
      add :banco_recebedor_id, references(:banco)
      add :banco_intermediario_id, references(:banco)
      add :notificador_id, references(:cliente)
      add :pagador_id, references(:cliente)
      add :registro_id, references(:registro)

      timestamps()
    end
  end
end
