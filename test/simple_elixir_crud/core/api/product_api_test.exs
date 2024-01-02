defmodule SimpleElixirCrud.Core.Product.ApiTest do
  use SimpleElixirCrud.DataCase

  alias SimpleElixirCrud.Core.Product

  describe "Products API" do
    setup do
      params = %{
        title: "um produto",
        description: "Meu primeiro produto"
      }

      {:ok, sucess_params: params}
    end

    test "Get all products" do
      assert {:ok, []} = Product.Api.all()
    end

    test "Insert one product", context do
      assert {:ok,
              %Product{
                title: title,
                description: description
              }} = Product.Api.insert(context.sucess_params)

      assert ^title = context.sucess_params.title
      assert ^description = context.sucess_params.description
    end

    test "Get all products afeter inster", context do
      for _i <- 1..10 do
        assert {:ok, _} = Product.Api.insert(context.sucess_params)
      end

      assert {:ok, items} = Product.Api.all()
      assert 10 = Enum.count(items)
    end
  end
end
