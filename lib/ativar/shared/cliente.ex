defmodule Ativar.Shared.Cliente do
  use Ativar, :model

  schema "cliente" do
    field :email_principal, :string
    field :email_adicionais, {:array, :string}
    field :nome, :string
    field :telefone, :string
    field :registro, :string
    field :acronimo, :string

    belongs_to :endereco, Ativar.Shared.Endereco, on_replace: :update

    timestamps()
  end

  def changeset(cliente \\ %Cliente{}, attrs) do
    cliente
    |> cast(attrs, [:nome, :email_principal, :email_adicionais, :telefone, :registro])
    |> cast_assoc(:endereco, required: true)
    |> put_acronimo(cliente.nome)
    |> validate_required([:nome, :email_principal, :telefone, :registro, :acronimo])
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
