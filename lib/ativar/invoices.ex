defmodule Ativar.Invoices do
  use Ativar, :context

  alias Ativar.Faturamento.Invoice

  def get_by_code(code) do
    code
    |> by_code_ilike()
    |> Repo.all()
    |> Repo.preload([:pagador, :registro])
  end

  defp query do
    from(i in Invoice)
  end

  defp by_code_ilike(query \\ query(), code) do
    where(query, [i], ilike(i.codigo, ^"%#{code}%"))
  end
end
