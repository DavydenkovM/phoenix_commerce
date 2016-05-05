defmodule PhoenixCommerce.Api.ProductController do
  use PhoenixCommerce.Web, :controller
  alias PhoenixCommerce.Product

  plug :scrub_params, "product" when action in [:create, :update]

  def create(conn, %{"product" => product_params}) do
    changeset = Product.changeset(%Product{}, product_params)

    case Repo.insert(changeset) do
      {:ok, _product} ->
        conn
        |> put_status(:ok)
        |> render("index.json", status: :ok)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end

  def index(conn, _params) do
    products = Repo.all(Product)
    render(conn, "index.json", products: products)
  end

  def show(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)
    render(conn, "show.html", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Repo.get!(Product, id)
    changeset = Product.changeset(product, product_params)

    case Repo.update(changeset) do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> render("index.json", status: :ok)
      {:error, changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)

    Repo.delete!(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> render("index.json", status: :ok)
  end
end
