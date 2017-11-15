defmodule Libellus.Core.Flyer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Libellus.Core.{Flyer, Organization}


  schema "flyers" do
    field :expiration_date, :date
    field :image_path, :string
    field :start_date, :date

    belongs_to :organization, Organization

    timestamps()
  end

  @doc false
  def changeset(%Flyer{} = flyer, attrs) do
    flyer
    |> cast(attrs, [:image_path, :start_date, :expiration_date])
    |> validate_required([:image_path, :start_date, :expiration_date])
  end
end
