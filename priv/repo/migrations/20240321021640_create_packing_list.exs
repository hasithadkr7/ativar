defmodule Ativar.Repo.Migrations.CreatePackingList do
  use Ecto.Migration

  def change do
    create table(:packing_list) do
      add :codigo_hs, :string
      add :cliente_manufaturador_id, references(:cliente)
      add :invoice_id, references(:invoice)
    end

    create index(:packing_list, [:invoice_id])
    create index(:packing_list, [:client_manufaturador_id])
  end
end
