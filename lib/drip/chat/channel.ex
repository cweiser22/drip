defmodule Drip.Chat.Channel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "channels" do
    field :name, :string
    # field :server_id, :id

    belongs_to :server, Drip.Chat.Server
    has_many :messages, Drip.Chat.Message


    timestamps(type: :utc_datetime)
  end

  @doc false
  def create_changeset(channel, attrs) do
    channel
    |> cast(attrs, [:name, :server_id])
    |> validate_required([:name, :server_id])
  end

  def update_changeset(channel, attrs) do
    channel
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
