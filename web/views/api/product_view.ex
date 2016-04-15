defmodule PhoenixCommerce.Api.ProductView do
  use PhoenixCommerce.Web, :view

  def render("index.json", %{products: products}) do
    products
  end

  def render("index.json", resp=%{status: status}) do
    %{status: status}
  end

  def render("error.json", %{changeset: changeset}) do
    errors = Enum.into(changeset.errors, %{})

    %{
      errors: errors
    }
  end

  def product_image(product) do
    if !product.image do
      nil
    else
      PhoenixCommerce.Image.url({product.image, product}, :thumb)
      |> upload_path
    end
  end
end
