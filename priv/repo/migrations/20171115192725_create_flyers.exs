defmodule Libellus.Repo.Migrations.CreateFlyers do
  use Ecto.Migration

  def change do
    create table(:flyers) do
      add :image_path, :string
      add :start_date, :date
      add :expiration_date, :date
      add :organization_id, references("organizations")

      timestamps()
    end

    create index(:flyers, [:organization_id])
  end
end
