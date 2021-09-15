defmodule DesVerwLiveWeb.OrganizationLive.Index do
  use DesVerwLiveWeb, :live_view

  alias DesVerwLive.Organizations
  alias DesVerwLive.Organizations.Organization

  @impl true
  def mount(_params, _session, socket) do
    organizations = list_organizations()
    socket = assign(socket,
              organizations: organizations,
              selected_organization: hd(organizations),
              assoc_name: "")
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    id = String.to_integer(id)

    organization = Organizations.get_organization!(id)

    socket =
      assign(socket,
        selected_organization: organization,
        page_title: organization.name)

    {:noreply, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end


  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Organization")
    |> assign(:organization, Organizations.get_organization!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Organization")
    |> assign(:organization, %Organization{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Organizations")
    |> assign(:organization, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    organization = Organizations.get_organization!(id)
    {:ok, _} = Organizations.delete_organization(organization)

    {:noreply, assign(socket, :organizations, list_organizations())}
  end

  def handle_event("name_search", %{"assoc_name" => name}, socket) do
    organizations = Organizations.suggest(name)
    if Enum.count(organizations) == 0 do
      ^organizations = list_organizations()
    end
    socket =
      assign(socket,
      assoc_name: "",
      organizations: organizations,
      selected_organization: hd(organizations)
    )
    {:noreply, socket}
  end

  defp list_organizations do
    Organizations.list_organizations()
  end

  defp link_body(organization) do
    assigns = %{name: organization.name}

    ~L"""
    <%= @name %>
    """
  end

end
