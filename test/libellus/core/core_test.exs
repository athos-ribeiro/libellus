defmodule Libellus.CoreTest do
  use Libellus.DataCase

  alias Libellus.Core

  describe "organizations" do
    alias Libellus.Core.Organization

    @valid_attrs %{address: "some address", lat: 120.5, logo: "some logo", long: 120.5, name: "some name"}
    @update_attrs %{address: "some updated address", lat: 456.7, logo: "some updated logo", long: 456.7, name: "some updated name"}
    @invalid_attrs %{address: nil, lat: nil, logo: nil, long: nil, name: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Core.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Core.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Core.create_organization(@valid_attrs)
      assert organization.address == "some address"
      assert organization.lat == 120.5
      assert organization.logo == "some logo"
      assert organization.long == 120.5
      assert organization.name == "some name"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, organization} = Core.update_organization(organization, @update_attrs)
      assert %Organization{} = organization
      assert organization.address == "some updated address"
      assert organization.lat == 456.7
      assert organization.logo == "some updated logo"
      assert organization.long == 456.7
      assert organization.name == "some updated name"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_organization(organization, @invalid_attrs)
      assert organization == Core.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Core.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Core.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Core.change_organization(organization)
    end
  end

  describe "flyers" do
    alias Libellus.Core.Flyer

    @valid_attrs %{expiration_date: ~D[2010-04-17], image_path: "some image_path", start_date: ~D[2010-04-17]}
    @update_attrs %{expiration_date: ~D[2011-05-18], image_path: "some updated image_path", start_date: ~D[2011-05-18]}
    @invalid_attrs %{expiration_date: nil, image_path: nil, start_date: nil}

    def flyer_fixture(attrs \\ %{}) do
      org = organization_fixture()
      {:ok, flyer} =
        attrs
        |> Map.put(:organization_id, org.id)
        |> Enum.into(@valid_attrs)
        |> Core.create_flyer()

      flyer
    end

    test "list_flyers/0 returns all flyers" do
      flyer = flyer_fixture()
      org_id = flyer.organization_id
      assert Core.list_flyers(org_id) == [flyer]
    end

    test "get_flyer!/1 returns the flyer with given id" do
      flyer = flyer_fixture()
      assert Core.get_flyer!(flyer.id) == flyer
    end

    test "create_flyer/1 with valid data creates a flyer" do
      attrs = Map.put(@valid_attrs, :organization_id, organization_fixture().id)
      assert {:ok, %Flyer{} = flyer} = Core.create_flyer(attrs)
      assert flyer.expiration_date == ~D[2010-04-17]
      assert flyer.image_path == "some image_path"
      assert flyer.start_date == ~D[2010-04-17]
    end

    test "create_flyer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_flyer(@invalid_attrs)
    end

    test "update_flyer/2 with valid data updates the flyer" do
      flyer = flyer_fixture()
      assert {:ok, flyer} = Core.update_flyer(flyer, @update_attrs)
      assert %Flyer{} = flyer
      assert flyer.expiration_date == ~D[2011-05-18]
      assert flyer.image_path == "some updated image_path"
      assert flyer.start_date == ~D[2011-05-18]
    end

    test "update_flyer/2 with invalid data returns error changeset" do
      flyer = flyer_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_flyer(flyer, @invalid_attrs)
      assert flyer == Core.get_flyer!(flyer.id)
    end

    test "delete_flyer/1 deletes the flyer" do
      flyer = flyer_fixture()
      assert {:ok, %Flyer{}} = Core.delete_flyer(flyer)
      assert_raise Ecto.NoResultsError, fn -> Core.get_flyer!(flyer.id) end
    end

    test "change_flyer/1 returns a flyer changeset" do
      flyer = flyer_fixture()
      assert %Ecto.Changeset{} = Core.change_flyer(flyer)
    end
  end
end
