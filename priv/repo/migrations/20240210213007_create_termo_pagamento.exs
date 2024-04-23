defmodule Ativar.Repo.Migrations.CreateTermoPagamento do
  use Ecto.Migration

  def change do
    create table(:termo_pagamento) do
      add :valor_total, :decimal
      add :moeda, :string
      add :descricao, :string
      add :numero_parcelas, :integer, default: 0
      add :registro_id, references(:registro)
      add :carregamento_id, references(:carregamento)
    end
  end
end
