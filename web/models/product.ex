defmodule PhoenixCommerce.Product do
  use PhoenixCommerce.Web, :model
  use Arc.Ecto.Model

  # @derive {Poison.Encoder, only: [:id, :description, :price]}

  schema "products" do
    field :name, :string
    field :description, :string
    field :image, PhoenixCommerce.Image.Type
    field :price, :decimal
    has_many :cart_items, PhoenixCommerce.CartItem

    timestamps
  end

  @required_fields ~w(name description price)
  @optional_fields ~w()

  @required_file_fields ~w()
  @optional_file_fields ~w(image)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
  end

  defimpl Poison.Encoder, for: PhoenixCommerce.Product do
    def encode(model, options) do
      model
      |> Map.take([:id, :description, :price])
      |> Map.put(:name, model.description)
      |> Map.put(:image, PhoenixCommerce.ProductView.product_image(model))
      |> Poison.Encoder.encode(options)
    end
  end
end
