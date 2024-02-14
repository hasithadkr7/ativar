defmodule Ativar.Repo.Migrations.CreateParcela do
  use Ecto.Migration

  def change do
    create table(:parcela) do
      add :valor, :decimal
      add :porcentagem, :float
      add :data_vencimento, :date
      add :comentario, :string
      add :status, :string
      add :termo_id, references(:termo_pagamento)
    end
  end
end
