defmodule Libellus.Core do
  @moduledoc """
  The Core context.
  """

  import Ecto.Query, warn: false
  alias Libellus.Repo

  alias Libellus.Core.Organization

  @doc """
  Returns the list of organizations.

  ## Examples

      iex> list_organizations()
      [%Organization{}, ...]

  """
  def list_organizations do
    Repo.all(Organization)
  end

  @doc """
  Gets a single organization.

  Raises `Ecto.NoResultsError` if the Organization does not exist.

  ## Examples

      iex> get_organization!(123)
      %Organization{}

      iex> get_organization!(456)
      ** (Ecto.NoResultsError)

  """
  def get_organization!(id), do: Repo.get!(Organization, id)

  @doc """
  Creates a organization.

  ## Examples

      iex> create_organization(%{field: value})
      {:ok, %Organization{}}

      iex> create_organization(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_organization(attrs \\ %{}) do
    %Organization{}
    |> Organization.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a organization.

  ## Examples

      iex> update_organization(organization, %{field: new_value})
      {:ok, %Organization{}}

      iex> update_organization(organization, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_organization(%Organization{} = organization, attrs) do
    organization
    |> Organization.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Organization.

  ## Examples

      iex> delete_organization(organization)
      {:ok, %Organization{}}

      iex> delete_organization(organization)
      {:error, %Ecto.Changeset{}}

  """
  def delete_organization(%Organization{} = organization) do
    Repo.delete(organization)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking organization changes.

  ## Examples

      iex> change_organization(organization)
      %Ecto.Changeset{source: %Organization{}}

  """
  def change_organization(%Organization{} = organization) do
    Organization.changeset(organization, %{})
  end

  alias Libellus.Core.Flyer

  @doc """
  Returns the list of flyers.

  ## Examples

      iex> list_flyers()
      [%Flyer{}, ...]

  """
  def list_flyers(organization_id) when is_integer(organization_id) do
    query = from f in Flyer, where: f.organization_id == ^organization_id
    Repo.all(query)
  end

  @doc """
  Gets a single flyer.

  Raises `Ecto.NoResultsError` if the Flyer does not exist.

  ## Examples

      iex> get_flyer!(123)
      %Flyer{}

      iex> get_flyer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flyer!(id), do: Repo.get!(Flyer, id)

  @doc """
  Creates a flyer.

  ## Examples

      iex> create_flyer(%{field: value})
      {:ok, %Flyer{}}

      iex> create_flyer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flyer(attrs \\ %{}) do
    %Flyer{}
    |> Flyer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a flyer.

  ## Examples

      iex> update_flyer(flyer, %{field: new_value})
      {:ok, %Flyer{}}

      iex> update_flyer(flyer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flyer(%Flyer{} = flyer, attrs) do
    flyer
    |> Flyer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Flyer.

  ## Examples

      iex> delete_flyer(flyer)
      {:ok, %Flyer{}}

      iex> delete_flyer(flyer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flyer(%Flyer{} = flyer) do
    Repo.delete(flyer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking flyer changes.

  ## Examples

      iex> change_flyer(flyer)
      %Ecto.Changeset{source: %Flyer{}}

  """
  def change_flyer(%Flyer{} = flyer) do
    Flyer.changeset(flyer, %{})
  end
end
