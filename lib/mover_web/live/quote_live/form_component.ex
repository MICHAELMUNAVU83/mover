defmodule MoverWeb.QuoteLive.FormComponent do
  use MoverWeb, :live_component

  alias Mover.Quotes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage quote records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="quote-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:from]} type="text" label="From" />
        <.input field={@form[:to]} type="text" label="To" />
        <.input field={@form[:bedroom_size]} type="number" label="Bedroom size" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Quote</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{quote: quote} = assigns, socket) do
    changeset = Quotes.change_quote(quote)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"quote" => quote_params}, socket) do
    changeset =
      socket.assigns.quote
      |> Quotes.change_quote(quote_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"quote" => quote_params}, socket) do
    save_quote(socket, socket.assigns.action, quote_params)
  end

  defp save_quote(socket, :edit, quote_params) do
    case Quotes.update_quote(socket.assigns.quote, quote_params) do
      {:ok, quote} ->
        notify_parent({:saved, quote})

        {:noreply,
         socket
         |> put_flash(:info, "Quote updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_quote(socket, :new, quote_params) do
    case Quotes.create_quote(quote_params) do
      {:ok, quote} ->
        notify_parent({:saved, quote})

        {:noreply,
         socket
         |> put_flash(:info, "Quote created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
