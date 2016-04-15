defmodule PhoenixCommerce.ProductView do
  use PhoenixCommerce.Web, :view

  def product_image(product) do
    PhoenixCommerce.Image.url({product.image, product}, :thumb)
    |> upload_path
  end
end
