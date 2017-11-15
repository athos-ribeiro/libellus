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
end
