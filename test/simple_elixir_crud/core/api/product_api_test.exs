defmodule SimpleElixirCrud.Core.Product.ApiTest do
  use SimpleElixirCrud.DataCase

  alias SimpleElixirCrud.Core.Product

  test "Get all products" do
    assert {:ok, []} = Product.Api.all()
  end

  test "Insert one product" do
    params = %{
      title: "um produto",
      description: "Meu primeiro produto"
    }

    assert {:ok,
            %Product{
              title: title,
              description: description
            }} = Product.Api.insert(params)

    assert ^title = params.title
    assert ^description = params.description
  end
end
