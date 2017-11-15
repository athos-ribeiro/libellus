defmodule Libellus.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string
      add :logo, :string
      add :address, :string
      add :lat, :float
      add :long, :float

      timestamps()
    end

  end
end
