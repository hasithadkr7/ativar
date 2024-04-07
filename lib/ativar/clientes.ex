defmodule Ativar.Clientes do
  @moduledoc false

  use Ativar, :context

  alias Ativar.Shared.Cliente
  alias Ativar.Repo

  def all_order_by_desc do
    query()
    |> order_by([c], desc: c.id)
    |> Repo.all()
  end

  def upsert(cliente, attrs) do
    cliente
    |> Cliente.changeset(attrs)
    |> Repo.insert_or_update()
  end

  def get_by_name(name) do
    name
    |> by_name_ilike()
    |> Repo.all()
    |> Repo.preload(:endereco)
  end

  defp query do
    from(c in Cliente)
  end

  defp by_name_ilike(query \\ query(), name) do
    where(query, [c], ilike(c.nome, ^"%#{name}%"))
  end
end
