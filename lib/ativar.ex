defmodule Ativar do
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
