defmodule Mover.Repo do
  use Ecto.Repo,
    otp_app: :mover,
    adapter: Ecto.Adapters.Postgres
end
