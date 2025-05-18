defmodule Drip.Chat.Server do
  use Ecto.Schema
  import Ecto.Changeset

  schema "servers" do
    field :name, :string
    field :icon_url, :string
    #field :owner_id, :id

    has_many :channels, Drip.Chat.Channel, foreign_key: :server_id

    belongs_to :owner, Drip.Accounts.User, foreign_key: :owner_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [:name, :icon_url, :owner_id])
    |> validate_required([:name, :icon_url, :owner_id])
  end

  def edit_changeset(server, attrs) do
    server
    |> cast(attrs, [:name, :icon_url])
    |> validate_required([:name, :icon_url])
  end


end
