defmodule Ativar.Faturamentos do
  @moduledoc false

  import Ecto.Query

  alias Ativar.Faturamento.Invoice
  alias Ativar.Pagamentos.Movimentacao
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

  def get_total_invoice_amount(invoice_id) do
    query =
      from i in Invoice,
        where: i.id == ^invoice_id,
        join: mov in assoc(i, :movimentacoes),
        preload: [movimentacoes: mov]

    if invoice = Repo.one(query) do
      for mov <- invoice.movimentacoes, reduce: Decimal.new(0) do
        acc ->
          case mov.tipo do
            :entrada -> Decimal.add(acc, mov.valor)
            :saida -> Decimal.sub(acc, mov.valor)
          end
      end
      |> then(&Decimal.to_integer/1)
    end
  end
end
