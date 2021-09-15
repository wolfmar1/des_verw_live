defmodule DesVerwLiveWeb.OrganizationLiveTest do
  use DesVerwLiveWeb.ConnCase

  import Phoenix.LiveViewTest

  alias DesVerwLive.Organizations

  @create_attrs %{assoc_no: "some assoc_no", edv: "some edv", name: "some name", name1: "some name1", name2: "some name2", officehours: "some officehours", phone: "some phone", rlformat: "some rlformat"}
  @update_attrs %{assoc_no: "some updated assoc_no", edv: "some updated edv", name: "some updated name", name1: "some updated name1", name2: "some updated name2", officehours: "some updated officehours", phone: "some updated phone", rlformat: "some updated rlformat"}
  @invalid_attrs %{assoc_no: nil, edv: nil, name: nil, name1: nil, name2: nil, officehours: nil, phone: nil, rlformat: nil}

  defp fixture(:organization) do
    {:ok, organization} = Organizations.create_organization(@create_attrs)
    organization
  end

  defp create_organization(_) do
    organization = fixture(:organization)
    %{organization: organization}
  end

  describe "Index" do
    setup [:create_organization]

    test "lists all organizations", %{conn: conn, organization: organization} do
      {:ok, _index_live, html} = live(conn, Routes.organization_index_path(conn, :index))

      assert html =~ "Listing Organizations"
      assert html =~ organization.assoc_no
    end

    test "saves new organization", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.organization_index_path(conn, :index))

      assert index_live |> element("a", "New Organization") |> render_click() =~
               "New Organization"

      assert_patch(index_live, Routes.organization_index_path(conn, :new))

      assert index_live
             |> form("#organization-form", organization: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#organization-form", organization: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.organization_index_path(conn, :index))

      assert html =~ "Organization created successfully"
      assert html =~ "some assoc_no"
    end

    test "updates organization in listing", %{conn: conn, organization: organization} do
      {:ok, index_live, _html} = live(conn, Routes.organization_index_path(conn, :index))

      assert index_live |> element("#organization-#{organization.id} a", "Edit") |> render_click() =~
               "Edit Organization"

      assert_patch(index_live, Routes.organization_index_path(conn, :edit, organization))

      assert index_live
             |> form("#organization-form", organization: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#organization-form", organization: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.organization_index_path(conn, :index))

      assert html =~ "Organization updated successfully"
      assert html =~ "some updated assoc_no"
    end

    test "deletes organization in listing", %{conn: conn, organization: organization} do
      {:ok, index_live, _html} = live(conn, Routes.organization_index_path(conn, :index))

      assert index_live |> element("#organization-#{organization.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#organization-#{organization.id}")
    end
  end

  describe "Show" do
    setup [:create_organization]

    test "displays organization", %{conn: conn, organization: organization} do
      {:ok, _show_live, html} = live(conn, Routes.organization_show_path(conn, :show, organization))

      assert html =~ "Show Organization"
      assert html =~ organization.assoc_no
    end

    test "updates organization within modal", %{conn: conn, organization: organization} do
      {:ok, show_live, _html} = live(conn, Routes.organization_show_path(conn, :show, organization))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Organization"

      assert_patch(show_live, Routes.organization_show_path(conn, :edit, organization))

      assert show_live
             |> form("#organization-form", organization: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#organization-form", organization: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.organization_show_path(conn, :show, organization))

      assert html =~ "Organization updated successfully"
      assert html =~ "some updated assoc_no"
    end
  end
end
