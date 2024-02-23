defmodule Ativar.Logistica.TransporteAereo do
  use Ativar, :model
  use SwissSchema, repo: Ativar.Repo

  schema "transporte_aereo" do
    field :companhia, :string
    field :codigo_embarque_exportador, :string
    field :codigo_embarque_importador, :string

    belongs_to :transporte, Ativar.Logistica.Transporte
  end

  @impl true
  def changeset(aereo \\ %TransporteAereo{}, attrs) do
    aereo
    |> cast(attrs, [:companhia, :codigo_embarque_exportador, :codigo_embarque_importador])
    |> validate_required([:companhia, :codigo_embarque_exportador, :codigo_embarque_importador])
  end
end
