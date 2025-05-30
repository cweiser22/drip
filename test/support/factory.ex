defmodule Drip.Factory do
  use ExMachina.Ecto, repo: Drip.Repo

  # User factory
  def user_factory do
    %Drip.Accounts.User{
      email: sequence(:email, &"user#{&1}@example.com"),
      hashed_password: "fakehash"
    }
  end

  # Server factory
  def server_factory do
    owner = insert(:user)

    %Drip.Chat.Server{
      name: sequence(:server_name, &"Server ##{&1}"),
      icon_url: Faker.Avatar.image_url(),
      owner: owner,
      owner_id: owner.id,
      memberships: []
    }
  end

  # Channel factory
  def channel_factory do
    server = insert(:server)

    %Drip.Chat.Channel{
      name: sequence(:channel_name, &"general-#{&1}"),
      server: server,
      server_id: server.id
    }
  end

  # Message factory
  def message_factory do
    now = NaiveDateTime.utc_now()
    sender = insert(:user)
    channel = insert(:channel)

    %Drip.Chat.Message{
      id: sequence(:message_id, & &1),
      body: Faker.Lorem.sentence(),
      sender: sender,
      channel: channel,
      inserted_at: now,
      updated_at: now
    }
  end

  # Membership factory
  def membership_factory do
    user = insert(:user)
    server = insert(:server)

    %Drip.Chat.Membership{
      user: user,
      server: server,
      user_id: user.id,
      server_id: server.id
    }
  end
end
