defmodule Ativar.Repo.Migrations.CreateGalpao do
  use Ecto.Migration

  def change do
    create table(:galpao) do
      add :nome, :string
      add :responsavel, :string
      add :global_gap, :string
    end
  end
end
