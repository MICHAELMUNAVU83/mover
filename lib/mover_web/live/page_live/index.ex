defmodule MoverWeb.PageLive.Index do
  use MoverWeb, :live_view
  alias Mover.Quotes
  alias Mover.Quotes.Quote

  def mount(_params, _session, socket) do
    changeset = Quotes.change_quote(%Quote{})

    {:ok,
     socket
     |> assign(quote: %Quote{})
     |> assign_form(changeset)}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  def handle_event("validate", %{"quote" => quote_params}, socket) do
    changeset =
      socket.assigns.quote
      |> Quotes.change_quote(quote_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"quote" => quote_params}, socket) do
    case Quotes.create_quote(quote_params) do
      {:ok, quote} ->
        notify_parent({:saved, quote})

        {:noreply,
         socket
         |> put_flash(:info, "Quote created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
