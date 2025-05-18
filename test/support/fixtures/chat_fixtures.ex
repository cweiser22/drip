defmodule Drip.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Drip.Chat` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{

      })
      |> Drip.Chat.create_message()

    message
  end

  @doc """
  Generate a server.
  """
  def server_fixture(attrs \\ %{}) do
    {:ok, server} =
      attrs
      |> Enum.into(%{

      })
      |> Drip.Chat.create_server()

    server
  end

  @doc """
  Generate a membership.
  """
  def membership_fixture(attrs \\ %{}) do
    {:ok, membership} =
      attrs
      |> Enum.into(%{

      })
      |> Drip.Chat.create_membership()

    membership
  end

  @doc """
  Generate a channel.
  """
  def channel_fixture(attrs \\ %{}) do
    {:ok, channel} =
      attrs
      |> Enum.into(%{

      })
      |> Drip.Chat.create_channel()

    channel
  end
end
