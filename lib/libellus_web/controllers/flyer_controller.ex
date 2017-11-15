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

  defp store_img(img) do
    if img do
        {:ok, content} = File.read(img.path)
        img_hash = :crypto.hash(:md5, content) |> Base.encode16
        extension = Path.extname(img.filename)
        img_path = "/tmp/#{img_hash}#{extension}"
        File.cp(img.path, img_path)
        {:ok, img_path}
    else
        :error
    end
  end

  def create(conn, %{"organization_id" => organization_id, "flyer" => flyer_params}) do
    img = case store_img(flyer_params["flyer_file"]) do
        {:ok, img_path} -> img_path
        :error -> nil
    end
    flyer_params = Map.put(flyer_params, "image_path", img)
    case Core.create_flyer(Map.put(flyer_params, "organization_id", organization_id)) do
    # if we do not have a "flyer_file", we do not want to create a new flyer
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
