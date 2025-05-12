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
    %Drip.Chat.Server{
      name: sequence(:server_name, &"Server ##{&1}"),
      icon_url: Faker.Avatar.image_url(),
      owner: build(:user)
    }
  end

  # Channel factory
  def channel_factory do
    %Drip.Chat.Channel{
      name: sequence(:channel_name, &"general-#{&1}"),
      server: build(:server)
    }
  end

  # Message factory
  def message_factory do
    %Drip.Chat.Message{
      body: Faker.Lorem.sentence(),
      sender: build(:user),
      channel: build(:channel)
    }
  end

  # Membership factory
  def membership_factory do
    %Drip.Chat.Membership{
      user: build(:user),
      server: build(:server)
    }
  end
end
