defmodule Drip.Repo do
  use Ecto.Repo,
    otp_app: :drip,
    adapter: Ecto.Adapters.Postgres
end
