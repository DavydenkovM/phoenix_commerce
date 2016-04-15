defmodule PhoenixCommerce.CartItemController do
  use PhoenixCommerce.Web, :controller

  alias PhoenixCommerce.CartItem

  def delete(conn, %{"id" => id}) do
    cart_item = Repo.get!(CartItem, id)

    Repo.delete!(cart_item)

    conn
    |> put_flash(:info, "Cart Item removed from cart successfully")
    |> redirect(to: cart_path(conn, :show))
  end

  def update(conn, %{"id" => id, "cart_item" => cart_item_params}) do
    cart_item = Repo.get!(CartItem, id)
    changeset = CartItem.changeset(cart_item, cart_item_params)

    case Repo.update(changeset) do
      {:ok, _cart_item} ->
        conn
        |> put_flash(:info, "Cart Item updated successfully")
        |> redirect(to: cart_path(conn, :show))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "There was a problem updating the cart item.")
        |> redirect(to: cart_path(conn, :show))
    end
  end
end
