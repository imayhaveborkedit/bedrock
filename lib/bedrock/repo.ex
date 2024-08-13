defmodule Bedrock.Repo do
  use Ecto.Repo,
    otp_app: :bedrock,
    adapter: Ecto.Adapters.Postgres
end
