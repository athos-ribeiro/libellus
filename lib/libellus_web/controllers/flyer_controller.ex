defmodule LibellusWeb.FlyerController do
  use LibellusWeb, :controller

  alias Libellus.Core
  alias Libellus.Core.Flyer

  def index(conn, %{"organization_id" => organization_id}) do
    flyers = Core.list_flyers()
    render(conn, "index.html", flyers: flyers)
  end

  def new(conn, %{"organization_id" => organization_id}) do
    changeset = Core.change_flyer(%Flyer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"organization_id" => organization_id, "flyer" => flyer_params}) do
    case Core.create_flyer(flyer_params) do
      {:ok, flyer} ->
        conn
        |> put_flash(:info, "Flyer created successfully.")
        |> redirect(to: organization_flyer_path(conn, organization_id, :show, flyer))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"organization_id" => organization_id, "id" => id}) do
    flyer = Core.get_flyer!(id)
    render(conn, "show.html", flyer: flyer)
  end

  def edit(conn, %{"organization_id" => organization_id, "id" => id}) do
    flyer = Core.get_flyer!(id)
    changeset = Core.change_flyer(flyer)
    render(conn, "edit.html", flyer: flyer, changeset: changeset)
  end

  def update(conn, %{"organization_id" => organization_id, "id" => id, "flyer" => flyer_params}) do
    flyer = Core.get_flyer!(id)

    case Core.update_flyer(flyer, flyer_params) do
      {:ok, flyer} ->
        conn
        |> put_flash(:info, "Flyer updated successfully.")
        |> redirect(to: organization_flyer_path(conn, organization_id, :show, flyer))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", flyer: flyer, changeset: changeset)
    end
  end

  def delete(conn, %{"organization_id" => organization_id, "id" => id}) do
    flyer = Core.get_flyer!(id)
    {:ok, _flyer} = Core.delete_flyer(flyer)

    conn
    |> put_flash(:info, "Flyer deleted successfully.")
    |> redirect(to: organization_flyer_path(conn, organization_id, :index))
  end
end
