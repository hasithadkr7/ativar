defmodule Ativar.Faturamentos do
  @moduledoc false

  import Ecto.Query

  alias Ativar.Faturamento.Invoice
  alias Ativar.Repo

  def get_latest_invoices do
    from(i in Invoice,
      order_by: [desc: i.inserted_at],
      limit: 4
    )
    |> Repo.all()
    |> Repo.preload(:pagador)
  end

  def get_total_invoices, do: Repo.aggregate(Invoice, :count, :id)
end
