defmodule Ativar.Repo do
  use Ecto.Repo,
    otp_app: :ativar,
    adapter: Ecto.Adapters.Postgres

  def fetch_by(source, fields) do
    if result = get_by(source, fields) do
      {:ok, result}
    else
      {:error, :not_found}
    end
  end

  def fetch(source, id) do
    fetch_by(source, id: id)
  end

  def fetch_one(query) do
    if result = one(query) do
      {:ok, result}
    else
      {:error, :not_found}
    end
  end
end
