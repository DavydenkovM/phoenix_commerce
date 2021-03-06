defmodule PhoenixCommerce.CartItem do
  use PhoenixCommerce.Web, :model

  schema "cart_items" do
    field :quantity, :integer
    belongs_to :cart, PhoenixCommerce.Cart
    belongs_to :product, PhoenixCommerce.Product
    belongs_to :order, PhoenixCommerce.Order

    timestamps
  end

  @required_fields ~w(product_id quantity)
  @optional_fields ~w(cart_id order_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
