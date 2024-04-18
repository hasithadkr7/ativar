defmodule Ativar.Vendas do
  @moduledoc false

  use Ativar, :context

  alias Ativar.Vendas.Registro
  alias Ativar.Shared.Cliente
  alias Ativar.Faturamento.Invoice

  @relations [
    :invoice,
    importador: [:endereco],
    carregamento: [:galpao, termo: [:parcelas]],
    transporte: [:transporte_aereo, :transporte_maritimo],
    termo: [:parcelas]
  ]

  def list_registro do
    Repo.all(from(r in Registro, preload: ^@relations))
  end

  def search_registros(search) do
    from(r in Registro,
      join: c in Cliente,
      on: c.id == r.importador_id,
      join: i in Invoice,
      on: i.registro_id == r.id,
      where: ilike(i.codigo, ^search) or ilike(c.nome, ^search) or ilike(r.nota_fiscal, ^search)
    )
    |> Repo.all()
  end

  def retrieve_registro(id) do
    Repo.fetch_one(from(r in Registro, where: r.id == ^id, preload: ^@relations))
  end

  def create_registro(attrs) do
    with {:ok, registro} <-
           %Registro{}
           |> Registro.create_changeset(attrs)
           |> Repo.insert() do
      {:ok, Repo.preload(registro, @relations)}
    end
  end

  def update_registro(registro, attrs) do
    with {:ok, changeset} <- Registro.changeset(registro, attrs),
         {:ok, registro} <- Repo.update(changeset) do
      {:ok, Repo.preload(registro, @relations)}
    end
  end

  def upsert_registro(registro, attrs) do
    registro
    |> Registro.changeset(attrs)
    |> Repo.insert_or_update()
  end

  defdelegate delete_registro(registro), to: Repo, as: :delete

  def change_registro(registro, changeset_fn, attrs \\ %{}) do
    changeset_fn.(registro, attrs)
  end
end
