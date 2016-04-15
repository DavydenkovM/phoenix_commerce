
defmodule PhoenixCommerce.RegisterTest do
  use ExUnit.Case
  alias PhoenixCommerce.{Product, Cart, CartItem, Repo, Register, Order}

  @upload %Plug.Upload{path: Path.relative_to_cwd("test/files/demo.jpg"), filename: "demo.jpg", content_type: "image/jpg"}

  setup do
    Repo.delete_all(CartItem)
    Repo.delete_all(Cart)
    Repo.delete_all(Product)
    {:ok, product} =
      Product.changeset(%Product{}, %{
        name: "Some product",
        description: "Some Description",
        price: Decimal.new("25.20"),
        image: @upload
      }) |> Repo.insert

      {:ok, cart} = 
        Cart.changeset(%Cart{}, %{}) 
        |> Repo.insert

      {:ok, _cart_item} = 
      CartItem.changeset(%CartItem{}, %{
        product_id: product.id,
        cart_id: cart.id,
        quantity: 1,
      }) |> Repo.insert

      {:ok, cart: cart}
  end

  test "ordering a cart introduces a new order with the cart's cart_items", %{cart: cart} do
    assert {:ok, %Order{}} = Register.order(cart)
  end

  # @tag :external
  test "charging for an order at Stripe", %{cart: cart} do
    guid = Ecto.UUID.generate
    params = [
      source: [
        object: "card",
        number: "4111111111111111",
        exp_month: 10,
        exp_year: 2020,
        country: "US",
        name: "Phoenix Commerce",
        cvc: 123
      ],
      metadata: [
        guid: guid
      ]
    ]
    amount = 2_520 # in cents
    # assert {:ok, charge} = Stripe.Charges.create(amount, params)
    assert {:ok, charge} = Register.charge(cart, params)
    {:ok, fetched_charge} = Stripe.Charges.get(charge.id)
    assert fetched_charge.metadata["guid"] == guid
    assert fetched_charge.amount == amount
  end
end
