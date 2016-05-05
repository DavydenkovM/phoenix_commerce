defmodule PhoenixCommerce.CartController do
  use PhoenixCommerce.Web, :controller
  alias PhoenixCommerce.{CartItem, Cart}

  plug :set_cart

  def set_cart(conn, _opts) do
    cart = case get_session(conn, :cart_uuid) do
      nil ->
        Repo.insert!(%Cart{})
      cart_uuid ->
        query =
          from c in Cart,
          where: c.uuid == ^cart_uuid
        Repo.one(query)
    end

    conn
    |> assign(:cart, cart)
    |> put_session(:cart_uuid, cart.uuid)
  end

  def show(conn, _params) do
    query =
      from ci in CartItem,
      where: ci.cart_id == ^conn.assigns[:cart].id,
      preload: [:product]

    cart_items = Repo.all(query)
    render conn, "show.html", %{cart_items: cart_items}
  end

  def add(conn, %{"product" => %{"id" => product_id}}) do
    CartItem.changeset(%CartItem{}, %{
      product_id: product_id,
      quantity: 1,
      cart_id: conn.assigns[:cart].id
    })
    |> Repo.insert!

    redirect conn, to: cart_path(conn, :show)
  end
end
