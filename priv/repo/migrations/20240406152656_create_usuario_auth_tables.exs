defmodule Ativar.Repo.Migrations.CreateUsuarioAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:usuario) do
      add :name, :string, null: false
      add :email, :citext, null: false
      add :hashed_password, :string, null: false
      add :confirmed_at, :naive_datetime
      timestamps(type: :utc_datetime)
    end

    create unique_index(:usuario, [:email])

    create table(:usuario_tokens) do
      add :user_id, references(:usuario, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:usuario_tokens, [:user_id])
    create unique_index(:usuario_tokens, [:context, :token])
  end
end
