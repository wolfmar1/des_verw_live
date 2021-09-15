defmodule DesVerwLive.AdministrationTest do
  use DesVerwLive.DataCase

  alias DesVerwLive.Administration

  describe "organizations" do
    alias DesVerwLive.Administration.Organization

    @valid_attrs %{changed_by: "some changed_by", city: "some city", edv: "some edv", email: "some email", name: "some name", name1: "some name1", name2: "some name2", org_number: "some org_number", phone: "some phone", rlformat: "some rlformat", street: "some street", street_no: "some street_no", zip: "some zip"}
    @update_attrs %{changed_by: "some updated changed_by", city: "some updated city", edv: "some updated edv", email: "some updated email", name: "some updated name", name1: "some updated name1", name2: "some updated name2", org_number: "some updated org_number", phone: "some updated phone", rlformat: "some updated rlformat", street: "some updated street", street_no: "some updated street_no", zip: "some updated zip"}
    @invalid_attrs %{changed_by: nil, city: nil, edv: nil, email: nil, name: nil, name1: nil, name2: nil, org_number: nil, phone: nil, rlformat: nil, street: nil, street_no: nil, zip: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Administration.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Administration.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Administration.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Administration.create_organization(@valid_attrs)
      assert organization.changed_by == "some changed_by"
      assert organization.city == "some city"
      assert organization.edv == "some edv"
      assert organization.email == "some email"
      assert organization.name == "some name"
      assert organization.name1 == "some name1"
      assert organization.name2 == "some name2"
      assert organization.org_number == "some org_number"
      assert organization.phone == "some phone"
      assert organization.rlformat == "some rlformat"
      assert organization.street == "some street"
      assert organization.street_no == "some street_no"
      assert organization.zip == "some zip"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Administration.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{} = organization} = Administration.update_organization(organization, @update_attrs)
      assert organization.changed_by == "some updated changed_by"
      assert organization.city == "some updated city"
      assert organization.edv == "some updated edv"
      assert organization.email == "some updated email"
      assert organization.name == "some updated name"
      assert organization.name1 == "some updated name1"
      assert organization.name2 == "some updated name2"
      assert organization.org_number == "some updated org_number"
      assert organization.phone == "some updated phone"
      assert organization.rlformat == "some updated rlformat"
      assert organization.street == "some updated street"
      assert organization.street_no == "some updated street_no"
      assert organization.zip == "some updated zip"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Administration.update_organization(organization, @invalid_attrs)
      assert organization == Administration.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Administration.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Administration.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Administration.change_organization(organization)
    end
  end
end
