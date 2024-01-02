defmodule SimpleElixirCrudWeb.ProductsController do
  @moduledoc false
  use SimpleElixirCrudWeb, :controller
  alias SimpleElixirCrud.ProductContext

  def all(conn, params) do
    case ProductContext.all(params) do
      {:ok, products} -> json(conn, %{data: products})
    end
  end

  def get(conn, params) do
    case ProductContext.get(params) do
      {:ok, product} -> json(conn, %{data: product})
      {:error, msg} -> put_status(conn, 422) |> json(%{error: msg})
    end
  end

  def create(conn, params) do
    case ProductContext.create(params) do
      {:ok, product} -> json(conn, %{data: product})
      {:error, msg} -> put_status(conn, 422) |> json(%{error: msg})
    end
  end

  def update(conn, params) do
    case ProductContext.update(params) do
      {:ok, product} -> json(conn, %{data: product})
      {:error, msg} -> put_status(conn, 422) |> json(%{error: msg})
    end
  end

  def delete(conn, params) do
    case ProductContext.delete(params) do
      {:ok, product} -> json(conn, %{data: product})
      {:error, msg} -> put_status(conn, 422) |> json(%{error: msg})
    end
  end
end
