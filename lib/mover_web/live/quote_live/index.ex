defmodule MoverWeb.QuoteLive.Index do
  use MoverWeb, :live_view

  alias Mover.Quotes
  alias Mover.Quotes.Quote

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :quotes, Quotes.list_quotes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Quote")
    |> assign(:quote, Quotes.get_quote!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Quote")
    |> assign(:quote, %Quote{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Quotes")
    |> assign(:quote, nil)
  end

  @impl true
  def handle_info({MoverWeb.QuoteLive.FormComponent, {:saved, quote}}, socket) do
    {:noreply, stream_insert(socket, :quotes, quote)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    quote = Quotes.get_quote!(id)
    {:ok, _} = Quotes.delete_quote(quote)

    {:noreply, stream_delete(socket, :quotes, quote)}
  end
end
