defmodule Mover.QuotesTest do
  use Mover.DataCase

  alias Mover.Quotes

  describe "quotes" do
    alias Mover.Quotes.Quote

    import Mover.QuotesFixtures

    @invalid_attrs %{to: nil, from: nil, bedroom_size: nil}

    test "list_quotes/0 returns all quotes" do
      quote = quote_fixture()
      assert Quotes.list_quotes() == [quote]
    end

    test "get_quote!/1 returns the quote with given id" do
      quote = quote_fixture()
      assert Quotes.get_quote!(quote.id) == quote
    end

    test "create_quote/1 with valid data creates a quote" do
      valid_attrs = %{to: "some to", from: "some from", bedroom_size: 42}

      assert {:ok, %Quote{} = quote} = Quotes.create_quote(valid_attrs)
      assert quote.to == "some to"
      assert quote.from == "some from"
      assert quote.bedroom_size == 42
    end

    test "create_quote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quotes.create_quote(@invalid_attrs)
    end

    test "update_quote/2 with valid data updates the quote" do
      quote = quote_fixture()
      update_attrs = %{to: "some updated to", from: "some updated from", bedroom_size: 43}

      assert {:ok, %Quote{} = quote} = Quotes.update_quote(quote, update_attrs)
      assert quote.to == "some updated to"
      assert quote.from == "some updated from"
      assert quote.bedroom_size == 43
    end

    test "update_quote/2 with invalid data returns error changeset" do
      quote = quote_fixture()
      assert {:error, %Ecto.Changeset{}} = Quotes.update_quote(quote, @invalid_attrs)
      assert quote == Quotes.get_quote!(quote.id)
    end

    test "delete_quote/1 deletes the quote" do
      quote = quote_fixture()
      assert {:ok, %Quote{}} = Quotes.delete_quote(quote)
      assert_raise Ecto.NoResultsError, fn -> Quotes.get_quote!(quote.id) end
    end

    test "change_quote/1 returns a quote changeset" do
      quote = quote_fixture()
      assert %Ecto.Changeset{} = Quotes.change_quote(quote)
    end
  end
end
