defmodule Ativar.API do
  @moduledoc """
  Ativar public API
  """

  alias __MODULE__
  alias Ativar.Repo
  alias Ecto.Changeset

  @type queryable :: Ecto.Queryable.t()
  @type changeset :: %Ecto.Changeset{}

  @callback all :: [struct]
  @callback all(queryable) :: [struct]
  @callback one(queryable) :: [struct]
  @callback create(map) :: {:ok, struct} | {:error, changeset}
  @callback create!(map) :: struct
  @callback update(struct, map) :: {:ok, struct} | {:error, changeset}
  @callback update!(struct, map) :: struct
  @callback get(any, keyword) :: struct | nil
  @callback delete(struct) :: {:ok, struct} | {:error, changeset}
  @callback undelete(struct) :: {:ok, struct} | {:error, changeset}
  @callback set_offset(queryable, integer) :: queryable
  @callback set_limit(queryable, integer) :: queryable
  @callback preload(struct | [struct], atom | [atom], Keyword.t()) :: struct | [struct]
  @callback transaction(function) :: {:ok, any} | {:error, any}
  @optional_callbacks all: 1,
                      one: 1,
                      delete: 1,
                      undelete: 1,
                      preload: 3,
                      transaction: 1

  defmacro __using__([schema: schema] = _opts) do
    quote do
      @behaviour API

      alias Ativar.Repo

      import Ecto.Query, except: [update: 2]

      schema_name =
        unquote(schema)
        |> Atom.to_string()
        |> String.replace_prefix("Elixir.Ativar.", "")

      @doc "Returns all `#{schema_name}` data"
      @spec all() :: [unquote(schema).t()]
      def all do
        Repo.all(unquote(schema))
      end

      @doc "Returns all `#{schema_name}` data from query"
      @spec all(Ecto.Queryable.t()) :: [unquote(schema).t()]
      def all(query), do: Repo.all(query)

      @doc "Returns one `#{schema_name}` data from query"
      @spec one(Ecto.Queryable.t()) :: unquote(schema).t()
      def one(query, opts \\ []), do: Repo.one(query, opts)

      @doc "Creates a `#{schema_name}` data"
      @spec create(map) :: {:ok, unquote(schema).t()} | {:error, Ecto.Changeset.t()}
      def create(attrs) do
        %unquote(schema){}
        |> unquote(schema).changeset(attrs)
        |> Repo.insert()
      end

      @doc "Creates a `#{schema_name}` data but raises on error"
      @spec create!(map) :: unquote(schema).t()
      def create!(attrs) do
        %unquote(schema){}
        |> unquote(schema).changeset(attrs)
        |> Repo.insert!()
      end

      @doc "Updates a `#{schema_name}` data"
      @spec update(unquote(schema).t(), map) ::
              {:ok, unquote(schema).t()} | {:error, Ecto.Changeset.t()}
      def update(%unquote(schema){} = data, attrs) do
        data
        |> unquote(schema).changeset(attrs)
        |> Repo.update()
      end

      @doc "Updates a `#{schema_name}` data but raises on error"
      @spec update!(unquote(schema).t(), map) :: unquote(schema).t()
      def update!(%unquote(schema){} = data, attrs) do
        data
        |> unquote(schema).changeset(attrs)
        |> Repo.update!()
      end

      # get/2 behaves differently for each id type, UUID or integer.

      %{id: id_type} = unquote(schema).__changeset__()

      if id_type == :binary_id do
        @doc "Gets a `#{schema_name}` data by its uuid"
        @spec get(Ecto.UUID.t()) :: unquote(schema).t() | nil
        def get(uuid, opts \\ []) do
          case Ecto.UUID.cast(uuid) do
            {:ok, uuid} -> Repo.get(unquote(schema), uuid, opts)
            :error -> nil
          end
        end
      else
        @doc "Gets a `#{schema_name}` data by its id"
        @spec get(integer) :: unquote(schema).t() | nil
        def get(id, opts \\ []) do
          Repo.get(unquote(schema), id, opts)
        end
      end

      # delete/1 and undelete/1 are available when
      # the struct has the `deleted_at` field.

      if :deleted_at in Map.keys(%unquote(schema){}) do
        @doc "Deletes a `#{schema_name}` data"
        @spec delete(unquote(schema).t()) ::
                {:ok, unquote(schema).t()} | {:error, Ecto.Changeset.t()}
        def delete(%unquote(schema){} = data) do
          attrs = %{deleted_at: Pro.Clock.now()}

          data
          |> Changeset.cast(attrs, [:deleted_at])
          |> Repo.update()
        end

        @doc "Reverts a `#{schema_name}` data deletion"
        @spec undelete(unquote(schema).t()) ::
                {:ok, unquote(schema).t()} | {:error, Ecto.Changeset.t()}
        def undelete(%unquote(schema){} = data) do
          attrs = %{deleted_at: nil}

          data
          |> Changeset.cast(attrs, [:deleted_at])
          |> Repo.update()
        end
      end

      @doc "Preload struct associations"
      @spec preload(unquote(schema).t() | [unquote(schema).t()], atom | [atom], Keyword.t()) ::
              unquote(schema).t() | [unquote(schema).t()]
      def preload(struct, preloads, opts \\ []) do
        Repo.preload(struct, preloads, opts)
      end

      @doc """
      Set query offset
      """
      @spec set_offset(Ecto.Queryable.t(), integer) :: Ecto.Queryable.t()
      def set_offset(query, offset), do: offset(query, ^offset)

      @doc """
      Set query limit
      """
      @spec set_limit(Ecto.Queryable.t(), integer) :: Ecto.Queryable.t()
      def set_limit(query, limit), do: limit(query, ^limit)

      @doc """
      Create transaction
      """
      @spec transaction(function, Keyword.t()) :: {:ok, any} | {:error, any}
      def transaction(function, opts), do: Repo.transaction(function, opts)

      @doc """
      Create stream
      """
      @spec stream(Ecto.Queryable.t()) :: Enum.t()
      def stream(query), do: Repo.stream(query)

      defoverridable API
    end
  end
end
