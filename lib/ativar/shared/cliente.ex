defmodule Ativar.Shared.Cliente do
  @moduledoc false

  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  schema "cliente" do
    field :nome, :string
    field :emails, {:array, :string}
    field :telefones, {:array, :string}
    field :registro, :string
    field :acronimo, :string
    field :endereco, :string
    field :moeda, Ecto.Enum, values: [:brl, :eur, :usd]
    field :cor, :string
    field :observacoes, :string

    timestamps()
  end

  @impl true
  def changeset(cliente \\ %Cliente{}, attrs) do
    cliente
    |> cast(attrs, [:nome, :emails, :telefones, :registro, :endereco, :moeda, :cor, :observacoes])
    |> put_acronimo(cliente.nome)
    |> validate_required([
      :nome,
      :emails,
      :telefones,
      :registro,
      :acronimo,
      :endereco,
      :cor,
      :moeda
    ])
  end

  defp put_acronimo(%{valid?: false} = changeset, _nome), do: changeset

  defp put_acronimo(changeset, current_name) do
    nome = get_change(changeset, :nome) || current_name || ""
    put_change(changeset, :acronimo, abbreviate(nome))
  end

  defp abbreviate(string) do
    ~r/[\s\-\_]/
    |> Regex.split(string, trim: true)
    |> Enum.map_join(&String.at(&1, 0))
    |> String.upcase()
  end
end
