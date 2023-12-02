defmodule Ativar.Logistica.TransporteMaritimo do
  use Ativar, :model

  schema "transporte_maritimo" do
    field :reserva, :string
    field :navio, :string
    field :viagem, :string
    field :armador, :string
    field :frete, :decimal

    belongs_to :transporte, Ativar.Logistica.Transporte
  end

  def changeset(maritimo \\ %TransporteMaritimo{}, attrs) do
    cast(maritimo, attrs, [:reserva, :navio, :viagem, :armador, :frete])
  end
end
