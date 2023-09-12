defmodule Mover.QuotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mover.Quotes` context.
  """

  @doc """
  Generate a quote.
  """
  def quote_fixture(attrs \\ %{}) do
    {:ok, quote} =
      attrs
      |> Enum.into(%{
        to: "some to",
        from: "some from",
        bedroom_size: 42
      })
      |> Mover.Quotes.create_quote()

    quote
  end
end
