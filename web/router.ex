defmodule PhoenixCommerce.Router do
  use PhoenixCommerce.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhoenixCommerce.Api, as: :api do
    pipe_through :api

    resources "/products", ProductController, only: [:create, :index, :update, :show, :delete]
  end

  scope "/", PhoenixCommerce do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "products", ProductController
    get "/cart", CartController, :show
    post "/cart/add", CartController, :add, as: :add_to_cart
    resources "/cart_items", CartItemController

    get "*path", PageController, :index
  end
end
