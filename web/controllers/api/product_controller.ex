defmodule PhoenixCommerce.Api.ProductController do
  use PhoenixCommerce.Web, :controller

  alias PhoenixCommerce.Product

  # @upload %Plug.Upload{path: Path.relative_to_cwd("test/files/demo.jpg"), filename: "demo.jpg", content_type: "image/jpg"}

  plug :scrub_params, "product" when action in [:create, :update]

  def index(conn, _params) do
    products = Repo.all(Product)
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    changeset = Product.changeset(%Product{}, product_params)

    case Repo.insert(changeset) do
      {:ok, _product} ->
        conn
        |> render("index.json", status: :ok)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end
end
