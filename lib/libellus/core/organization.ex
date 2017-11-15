defmodule Libellus.Core.Organization do
  use Ecto.Schema
  import Ecto.Changeset
  alias Libellus.Core.Organization


  schema "organizations" do
    field :address, :string
    field :lat, :float
    field :logo, :string
    field :long, :float
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Organization{} = organization, attrs) do
    organization
    |> cast(attrs, [:name, :logo, :address, :lat, :long])
    |> validate_required([:name, :logo, :address, :lat, :long])
  end
end
