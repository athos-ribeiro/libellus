defmodule LibellusWeb.Router do
  use LibellusWeb, :router

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

  scope "/", LibellusWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/organizations", OrganizationController do
      resources "/flyers", FlyerController
    end

  end

  # Other scopes may use custom stacks.
  # scope "/api", LibellusWeb do
  #   pipe_through :api
  # end
end
