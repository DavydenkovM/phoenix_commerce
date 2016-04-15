defmodule PhoenixCommerce.CartItemTest do
  use PhoenixCommerce.ModelCase

  alias PhoenixCommerce.{CartItem, Repo, Cart, Product}

  @product Repo.insert!(%Product{name: "Some product", description: "Some product", price: Decimal.new("22.50")})
  @cart Repo.insert!(%Cart{})
  @valid_attrs %{quantity: 42, product_id: @product.id, cart_id: @cart.id}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CartItem.changeset(%CartItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CartItem.changeset(%CartItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
