defmodule PhoenixCommerce.Register do
  alias PhoenixCommerce.{Cart, CartItem, Order, Repo}
  import Ecto.Query

  @spec order(%Cart{}) :: {:ok, %Order{}}
  def order(cart=%Cart{}) do
    IO.inspect Repo.transaction(fn()->
      order =
        Order.changeset(%Order{}, %{})
        |> Repo.insert!

      cart_items =
        from ci in CartItem,
        where: ci.cart_id == ^cart.id

      {_count, _returnval} =
        cart_items
        |> Repo.update_all(set: [cart_id: nil, order_id: order.id])

      order
    end)
  end

  @spec charge(%Cart{}, term()) :: {:ok, map()}
  def charge(cart=%Cart{}, params) do
    amount = cart_amount(cart)

    amount_in_cents_d = Decimal.mult(amount, Decimal.new(100))
    {amount_in_cents_d, _} = amount_in_cents_d |> Decimal.to_string |> Integer.parse

    Stripe.Charges.create(amount_in_cents_d, params)
  end

  defp cart_amount(cart=%Cart{}) do
    cart_items_query =
      from ci in CartItem,
      join: product in assoc(ci, :product),
      where: ci.cart_id == ^cart.id,
      select: [product.price, ci.quantity]

    _cart_items = Repo.all(cart_items_query)
    |> Enum.reduce(Decimal.new("0"), fn([price, quantity], acc) ->
      quantity = Decimal.new(quantity)
      Decimal.add(acc, Decimal.mult(price, quantity))
    end)
  end
end
