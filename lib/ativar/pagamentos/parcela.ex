defmodule Ativar.Pagamentos.Parcela do
  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  schema "parcela" do
    field :valor, :decimal
    field :porcentagem, :float
    field :data_vencimento, :date
    field :comentario, :string
    field :status, Ecto.Enum, values: ~w[pendente paga atrasada]a, default: :pendente

    belongs_to :termo, Ativar.Pagamentos.Termo
  end

  @impl true
  def changeset(parcela \\ %Parcela{}, attrs) do
    parcela
    |> cast(attrs, [:valor, :porcentagem, :data_vencimento, :comentario, :status])
    |> validate_required([:valor, :porcentagem, :data_vencimento])
  end
end
