defmodule DesVerwLive.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "auftraggeber" do
    field :assoc_no, :string, source: :vereinsnummer
    field :edv, :string, source: :edv
    field :name, :string, source: :name
    field :name1, :string, source: :name1
    field :name2, :string, source: :name2
    # field :officehours, :string
    field :phone, :string, source: :telefon
    field :rlformat, :string

    # timestamps(inserted_at_source: :created_on, updated_at_source: :changed_on )
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :name1, :name2, :phone, :assoc_no, :officehours, :edv, :rlformat])
    |> validate_required([:name, :name1, :name2, :phone, :assoc_no, :officehours, :edv, :rlformat])
  end
end
