defmodule DesVerwLive.Administration.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :changed_by, :string
    field :city, :string
    field :edv, :string
    field :email, :string
    field :name, :string
    field :name1, :string
    field :name2, :string
    field :org_number, :string
    field :phone, :string
    field :rlformat, :string
    field :street, :string
    field :street_no, :string
    field :zip, :string

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :name1, :name2, :org_number, :street, :street_no, :zip, :city, :email, :phone, :edv, :rlformat, :changed_by])
    |> validate_required([:name, :name1, :name2, :org_number, :street, :street_no, :zip, :city, :email, :phone, :edv, :rlformat, :changed_by])
  end
end
