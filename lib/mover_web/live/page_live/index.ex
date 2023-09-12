defmodule MoverWeb.PageLive.Index do
  use MoverWeb, :live_view
  alias Mover.Quotes
  alias Mover.Quotes.Quote

  def mount(_params, _session, socket) do
    changeset = Quotes.change_quote(%Quote{})

    {:ok,
     socket
     |> assign_form(changeset)}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
