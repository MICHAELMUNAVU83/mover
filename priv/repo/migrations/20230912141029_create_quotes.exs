defmodule Mover.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :from, :string
      add :to, :string
      add :bedroom_size, :integer

      timestamps()
    end
  end
end
