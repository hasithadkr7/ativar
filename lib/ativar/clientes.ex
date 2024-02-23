defmodule Ativar.Clientes do
  @moduledoc false

  use Ativar, :context

  alias Ativar.Shared.Cliente

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
