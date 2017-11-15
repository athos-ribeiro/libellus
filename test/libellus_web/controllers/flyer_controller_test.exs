defmodule LibellusWeb.FlyerControllerTest do
  use LibellusWeb.ConnCase

  alias Libellus.Core

  @create_attrs %{expiration_date: ~D[2010-04-17], image_path: "some image_path", start_date: ~D[2010-04-17]}
  @update_attrs %{expiration_date: ~D[2011-05-18], image_path: "some updated image_path", start_date: ~D[2011-05-18]}
  @invalid_attrs %{expiration_date: nil, image_path: nil, start_date: nil}

  def fixture(:flyer) do
    {:ok, flyer} = Core.create_flyer(@create_attrs)
    flyer
  end

  describe "index" do
    test "lists all flyers", %{conn: conn} do
      conn = get conn, flyer_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Flyers"
    end
  end

  describe "new flyer" do
    test "renders form", %{conn: conn} do
      conn = get conn, flyer_path(conn, :new)
      assert html_response(conn, 200) =~ "New Flyer"
    end
  end

  describe "create flyer" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, flyer_path(conn, :create), flyer: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == flyer_path(conn, :show, id)

      conn = get conn, flyer_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Flyer"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, flyer_path(conn, :create), flyer: @invalid_attrs
      assert html_response(conn, 200) =~ "New Flyer"
    end
  end

  describe "edit flyer" do
    setup [:create_flyer]

    test "renders form for editing chosen flyer", %{conn: conn, flyer: flyer} do
      conn = get conn, flyer_path(conn, :edit, flyer)
      assert html_response(conn, 200) =~ "Edit Flyer"
    end
  end

  describe "update flyer" do
    setup [:create_flyer]

    test "redirects when data is valid", %{conn: conn, flyer: flyer} do
      conn = put conn, flyer_path(conn, :update, flyer), flyer: @update_attrs
      assert redirected_to(conn) == flyer_path(conn, :show, flyer)

      conn = get conn, flyer_path(conn, :show, flyer)
      assert html_response(conn, 200) =~ "some updated image_path"
    end

    test "renders errors when data is invalid", %{conn: conn, flyer: flyer} do
      conn = put conn, flyer_path(conn, :update, flyer), flyer: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Flyer"
    end
  end

  describe "delete flyer" do
    setup [:create_flyer]

    test "deletes chosen flyer", %{conn: conn, flyer: flyer} do
      conn = delete conn, flyer_path(conn, :delete, flyer)
      assert redirected_to(conn) == flyer_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, flyer_path(conn, :show, flyer)
      end
    end
  end

  defp create_flyer(_) do
    flyer = fixture(:flyer)
    {:ok, flyer: flyer}
  end
end
