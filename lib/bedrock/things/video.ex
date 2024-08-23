defmodule Bedrock.Things.Video do
  use Ecto.Schema

  # @video_id_regex ~r/[0-9A-Za-z_-]{10}[048AEIMQUYcgkosw]/
  # @channel_id_regex ~r/[0-9A-Za-z_-]{21}[AQgw]/

  schema "videos" do
    field :video_id, :string, primary_key: true
    field :channel_id, :string
    field :channel_name, :string
    field :processed, :boolean
    field :data, :string, redact: true

    timestamps()
  end

  def changeset(video, params \\ %{}) do
    video
    |> Ecto.Changeset.cast(params, [:video_id, :channel_id, :channel_name, :processed, :data])
    |> Ecto.Changeset.validate_required([:video_id])
    |> Ecto.Changeset.unique_constraint([:video_id])
    # |> Ecto.Changeset.validate_format(:video_id, @video_id_regex)
  end
end
