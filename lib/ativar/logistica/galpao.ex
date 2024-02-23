defmodule Ativar.Logistica.Galpao do
  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  schema "galpao" do
    field :nome, :string
    field :responsavel, :string
    field :global_gap, :string

    has_many :carregamentos, Ativar.Logistica.Carregamento
  end

  @impl true
  def changeset(galpao \\ %Galpao{}, attrs) do
    galpao
    |> cast(attrs, [:nome, :responsavel, :global_gap])
    |> validate_required([:nome, :responsavel, :global_gap])
  end
end
