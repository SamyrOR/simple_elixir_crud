defmodule SimpleElixirCrud.Repo do
  use Ecto.Repo,
    otp_app: :simple_elixir_crud,
    adapter: Ecto.Adapters.Postgres
end
