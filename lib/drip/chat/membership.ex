defmodule Drip.Chat.Membership do
  use Ecto.Schema
  import Ecto.Changeset

  schema "memberships" do

    belongs_to :user, Drip.Accounts.User
    belongs_to :server, Drip.Chat.Server

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(membership, attrs) do
    membership
    |> cast(attrs, [])
    |> validate_required([])
  end
end
