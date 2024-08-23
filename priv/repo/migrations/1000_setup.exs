defmodule Bedrock.Repo.Migrations.Setup do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :video_id, :text, primary_key: true
      add :channel_id, :text
      add :channel_name, :text
      add :processed, :boolean, default: false
      add :data, :jsonb

      timestamps()
    end
  end
end
