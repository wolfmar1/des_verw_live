defmodule DesVerwLive.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string
      add :name1, :string
      add :name2, :string
      add :org_number, :string
      add :street, :string
      add :street_no, :string
      add :zip, :string
      add :city, :string
      add :email, :string
      add :phone, :string
      add :edv, :string
      add :rlformat, :string
      add :changed_by, :string

      timestamps()
    end

  end
end
