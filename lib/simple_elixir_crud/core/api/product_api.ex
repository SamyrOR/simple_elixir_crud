defmodule SimpleElixirCrud.Core.Product.Api do
  @moduledoc false

  alias SimpleElixirCrud.Repo
  alias SimpleElixirCrud.Core.Product

  import Ecto.Query

  def all do
    {:ok, Repo.all(Product)}
  end

  def get(id) do
    Repo.get(Product, id)
    |> case do
      nil -> {:error, :not_found}
      product -> {:ok, product}
    end
  end

  def get_by(where) do
    from(Product) |> where(^where) |> Repo.one()
  end

  def delete(id) do
    case get(id) do
      {:ok, product} -> Repo.delete(product)
      error -> error
    end
  end

  def insert(params) do
    %Product{}
    |> Product.changeset(params)
    |> Repo.insert()
  end

  def update(model, params) do
    model |> Product.changeset(params) |> Repo.update()
  end

  def json!(model, permission) do
    Map.take(model, Product.permission(permission))
  end
end
