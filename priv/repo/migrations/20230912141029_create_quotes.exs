defmodule Mover.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :from, :string
      add :to, :string
      add :bedroom_size, :integer
      add :latitude_to, :float
      add :longitude_to, :float
      add :latitude_from, :float
      add :longitude_from, :float

      timestamps()
    end
  end
end
