defmodule DesVerwLive.OrganizationsTest do
  use DesVerwLive.DataCase

  alias DesVerwLive.Organizations

  describe "organizations" do
    alias DesVerwLive.Organizations.Organization

    @valid_attrs %{assoc_no: "some assoc_no", edv: "some edv", name: "some name", name1: "some name1", name2: "some name2", officehours: "some officehours", phone: "some phone", rlformat: "some rlformat"}
    @update_attrs %{assoc_no: "some updated assoc_no", edv: "some updated edv", name: "some updated name", name1: "some updated name1", name2: "some updated name2", officehours: "some updated officehours", phone: "some updated phone", rlformat: "some updated rlformat"}
    @invalid_attrs %{assoc_no: nil, edv: nil, name: nil, name1: nil, name2: nil, officehours: nil, phone: nil, rlformat: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Organizations.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Organizations.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Organizations.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Organizations.create_organization(@valid_attrs)
      assert organization.assoc_no == "some assoc_no"
      assert organization.edv == "some edv"
      assert organization.name == "some name"
      assert organization.name1 == "some name1"
      assert organization.name2 == "some name2"
      assert organization.officehours == "some officehours"
      assert organization.phone == "some phone"
      assert organization.rlformat == "some rlformat"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organizations.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{} = organization} = Organizations.update_organization(organization, @update_attrs)
      assert organization.assoc_no == "some updated assoc_no"
      assert organization.edv == "some updated edv"
      assert organization.name == "some updated name"
      assert organization.name1 == "some updated name1"
      assert organization.name2 == "some updated name2"
      assert organization.officehours == "some updated officehours"
      assert organization.phone == "some updated phone"
      assert organization.rlformat == "some updated rlformat"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Organizations.update_organization(organization, @invalid_attrs)
      assert organization == Organizations.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Organizations.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Organizations.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Organizations.change_organization(organization)
    end
  end
end
