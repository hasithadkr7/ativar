defmodule Ativar.Shared.Endereco do
  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  schema "endereco" do
    field :rua, :string
    field :pais, :string
    field :estado, :string
    field :cidade, :string
    field :codigo_postal, :string
    field :numero, :string

    timestamps()
  end

  @impl true
  def changeset(endereco \\ %Endereco{}, attrs) do
    endereco
    |> cast(attrs, [:rua, :pais, :estado, :cidade, :codigo_postal, :numero])
    |> validate_required([:rua, :pais, :estado, :cidade, :codigo_postal, :numero])
  end
end
