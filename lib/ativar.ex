defmodule Ativar do
  @moduledoc """
  Ativar keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defmacro __using__(which) do
    apply(__MODULE__, which, [])
  end

  def context do
    quote do
      import Ecto.Query
      alias Ativar.Repo
    end
  end

  def model do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      alias __MODULE__
    end
  end

  def schema do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      alias __MODULE__
    end
  end
end
