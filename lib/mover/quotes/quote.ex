defmodule Mover.Quotes.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    field :to, :string
    field :from, :string
    field :bedroom_size, :integer
    field :latitude_to, :float
    field :longitude_to, :float
    field :latitude_from, :float
    field :longitude_from, :float

    timestamps()
  end

  @doc false
  def changeset(quote, attrs) do
    quote
    |> cast(attrs, [
      :from,
      :to,
      :bedroom_size,
      :latitude_to,
      :longitude_to,
      :latitude_from,
      :longitude_from
    ])
    |> validate_required([
      :from,
      :to,
      :bedroom_size,
      :latitude_to,
      :longitude_to,
      :latitude_from,
      :longitude_from
    ])
  end
end
