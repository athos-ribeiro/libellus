defmodule LibellusWeb.FlyerControllerTest do
  use LibellusWeb.ConnCase

  alias Libellus.Core

  @organization_attrs %{address: "some address", lat: 120.5, logo: "some logo", long: 120.5, name: "some name"}
  @create_attrs %{expiration_date: ~D[2010-04-17], image_path: "some image_path", start_date: ~D[2010-04-17]}
  @update_attrs %{expiration_date: ~D[2011-05-18], image_path: "some updated image_path", start_date: ~D[2011-05-18]}
  @invalid_attrs %{expiration_date: nil, image_path: nil, start_date: nil}

  def fixture(:organization) do
    {:ok, org} = Core.create_organization(@organization_attrs)
    org
  end

  def fixture(:flyer, include_organization \\ false) do
    org = fixture(:organization)
    {:ok, flyer} = Core.create_flyer(Map.put(@create_attrs, :organization_id, org.id))
    if include_organization do
      %{organization: org, flyer: flyer}
    else
      flyer
    end
  end

  describe "index" do
    test "lists all flyers from an organization", %{conn: conn} do
      org = fixture(:organization)
      conn = get conn, organization_flyer_path(conn, :index, org.id)
      assert html_response(conn, 200) =~ "Listing Flyers"
    end
  end

  describe "new flyer" do
    test "renders form", %{conn: conn} do
      org = fixture(:organization)
      conn = get conn, organization_flyer_path(conn, :new, org.id)
      assert html_response(conn, 200) =~ "New Flyer"
    end
  end

  describe "create flyer" do
    setup [:create_flyer]

    test "redirects to show when data is valid", %{conn: conn, flyer: flyer} do
      organization_id = flyer.organization_id
      conn = post conn, organization_flyer_path(conn, :create, organization_id), flyer: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == organization_flyer_path(conn, :show, organization_id, id)

      conn = get conn, organization_flyer_path(conn, :show, organization_id, id)
      assert html_response(conn, 200) =~ "Show Flyer"
    end

    test "renders errors when data is invalid", %{conn: conn, flyer: flyer} do
      organization_id = flyer.organization_id
      conn = post conn, organization_flyer_path(conn, :create, organization_id), flyer: @invalid_attrs
      assert html_response(conn, 200) =~ "New Flyer"
    end
  end

  describe "edit flyer" do
    setup [:create_flyer]

    test "renders form for editing chosen flyer", %{conn: conn, flyer: flyer} do
      organization_id = flyer.organization_id
      conn = get conn, organization_flyer_path(conn, :edit, organization_id, flyer)
      assert html_response(conn, 200) =~ "Edit Flyer"
    end
  end

  describe "update flyer" do
    setup [:create_flyer]

    test "redirects when data is valid", %{conn: conn, flyer: flyer} do
      organization_id = flyer.organization_id
      conn = put conn, organization_flyer_path(conn, :update, organization_id, flyer), flyer: @update_attrs
      assert redirected_to(conn) == organization_flyer_path(conn, :show, organization_id, flyer)

      conn = get conn, organization_flyer_path(conn, :show, organization_id, flyer)
      assert html_response(conn, 200) =~ "some updated image_path"
    end

    test "renders errors when data is invalid", %{conn: conn, flyer: flyer} do
      organization_id = flyer.organization_id
      conn = put conn, organization_flyer_path(conn, :update, organization_id, flyer), flyer: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Flyer"
    end
  end

  describe "delete flyer" do
    setup [:create_flyer]

    test "deletes chosen flyer", %{conn: conn, flyer: flyer} do
      organization_id = flyer.organization_id
      conn = delete conn, organization_flyer_path(conn, :delete, organization_id, flyer)
      assert redirected_to(conn) == organization_flyer_path(conn, :index, organization_id)
      assert_error_sent 404, fn ->
        get conn, organization_flyer_path(conn, :show, organization_id, flyer)
      end
    end
  end

  defp create_flyer(_) do
    flyer = fixture(:flyer)
    {:ok, flyer: flyer}
  end
end
