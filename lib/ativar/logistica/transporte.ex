defmodule Ativar.Logistica.Transporte do
  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  schema "transporte" do
    field :origem, :string
    field :destino, :string
    field :tipo, Ecto.Enum, values: [:aereo, :maritimo]

    has_one :transporte_aereo, Ativar.Logistica.TransporteAereo, on_replace: :update
    has_one :transporte_maritimo, Ativar.Logistica.TransporteMaritimo, on_replace: :update

    belongs_to :registro, Ativar.Vendas.Registro
  end

  @impl true
  def changeset(transporte \\ %Transporte{}, attrs) do
    transporte
    |> cast(attrs, [:origem, :destino, :tipo, :registro_id])
    |> cast_assoc(:transporte_aereo)
    |> cast_assoc(:transporte_maritimo)
    |> validate_required([:origem, :destino, :tipo])
  end
end
