defmodule LibellusWeb.FlyerController do
  use LibellusWeb, :controller

  alias Libellus.Core
  alias Libellus.Core.Flyer

  def index(conn, %{"organization_id" => organization_id}) do
    flyers = Core.list_flyers(organization_id)
    render(conn, "index.html", flyers: flyers, organization_id: organization_id)
  end

  def new(conn, %{"organization_id" => organization_id}) do
    changeset = Core.change_flyer(%Flyer{})
    render(conn, "new.html", changeset: changeset, organization_id: organization_id)
  end

  def create(conn, %{"organization_id" => organization_id, "flyer" => flyer_params}) do
    case Core.create_flyer(Map.put(flyer_params, "organization_id", organization_id)) do
      {:ok, flyer} ->
        conn
        |> put_flash(:info, "Flyer created successfully.")
        |> redirect(to: organization_flyer_path(conn, :show, organization_id, flyer))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, organization_id: organization_id)
    end
  end

  def show(conn, %{"organization_id" => organization_id, "id" => id}) do
    flyer = Core.get_flyer!(id)
    render(conn, "show.html", flyer: flyer, organization_id: organization_id)
  end

  def edit(conn, %{"organization_id" => organization_id, "id" => id}) do
    flyer = Core.get_flyer!(id)
    changeset = Core.change_flyer(flyer)
    render(conn, "edit.html", flyer: flyer, changeset: changeset, organization_id: organization_id)
  end

  def update(conn, %{"organization_id" => organization_id, "id" => id, "flyer" => flyer_params}) do
    flyer = Core.get_flyer!(id)

    case Core.update_flyer(flyer, Map.put(flyer_params, "organization_id", organization_id)) do
      {:ok, flyer} ->
        conn
        |> put_flash(:info, "Flyer updated successfully.")
        |> redirect(to: organization_flyer_path(conn, :show, organization_id, flyer))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", flyer: flyer, changeset: changeset, organization_id: organization_id)
    end
  end

  def delete(conn, %{"organization_id" => organization_id, "id" => id}) do
    flyer = Core.get_flyer!(id)
    {:ok, _flyer} = Core.delete_flyer(flyer)

    conn
    |> put_flash(:info, "Flyer deleted successfully.")
    |> redirect(to: organization_flyer_path(conn, :index, organization_id))
  end
end
