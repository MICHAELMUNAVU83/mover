defmodule Mover.Quotes.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    field :to, :string
    field :from, :string
    field :bedroom_size, :integer

    timestamps()
  end

  @doc false
  def changeset(quote, attrs) do
    quote
    |> cast(attrs, [:from, :to, :bedroom_size])
    |> validate_required([:from, :to, :bedroom_size])
  end
end
