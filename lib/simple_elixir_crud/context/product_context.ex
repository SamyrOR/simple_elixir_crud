defmodule SimpleElixirCrud.ProductContext do
  @moduledoc false

  alias SimpleElixirCrud.Core.Product
  alias SimpleElixirCrud.Validate

  def all(_params) do
    case Product.Api.all() do
      {:ok, products} -> {:ok, products |> Enum.map(&Product.Api.json!(&1, :public))}
    end
  end

  def get(params) do
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- Validate.is_integer(id, "id"),
         {:ok, product} <- Product.Api.get(id) do
      {:ok, product |> Product.Api.json!(:public)}
    else
      error -> error
    end
  end

  def create(params) do
    case Product.Api.insert(params) do
      {:ok, product} -> {:ok, product |> Product.Api.json!(:public)}
      {:error, changeset} -> {:error, parse_errors(changeset)}
    end
  end

  def update(params) do
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- Validate.is_integer(id, "id"),
         {:ok, product} <- Product.Api.get(id),
         {:ok, product_updated} <- Product.Api.update(product, params) do
      {:ok, product_updated |> Product.Api.json!(:public)}
    else
      {:error, %Ecto.Changeset{} = changeset} -> {:error, parse_errors(changeset)}
      error -> error
    end
  end

  def delete(params) do
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- Validate.is_integer(id, "id"),
         {:ok, product} <- Product.Api.delete(id) do
      {:ok, product |> Product.Api.json!(:public)}
    else
      error -> error
    end
  end

  defp parse_errors(changeset) do
    Enum.map(changeset.errors, fn {key, {msg, _}} -> "#{key}: #{msg}" end)
  end
end
