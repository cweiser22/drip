defmodule Drip.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string
    # field :sender_id, :id
    # field :channel_id, :id

    belongs_to :sender, Drip.Accounts.User, foreign_key: :sender_id
    belongs_to :channel, Drip.Chat.Channel

    timestamps(type: :utc_datetime)
  end

  def create_changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :channel_id, :sender_id])
    |> validate_required([:body, :channel_id])
  end

  def update_changeset(message, attrs) do
    message
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end

  @type t :: %__MODULE__{}
end
