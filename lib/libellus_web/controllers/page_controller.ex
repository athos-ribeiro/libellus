defmodule LibellusWeb.PageController do
  use LibellusWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
