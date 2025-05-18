defmodule Drip.ChatTest do
  use Drip.DataCase

  alias Drip.Chat

  describe "messages" do
    alias Drip.Chat.Message

    import Drip.ChatFixtures

    @invalid_attrs %{}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Chat.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chat.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{}

      assert {:ok, %Message{} = message} = Chat.create_message(valid_attrs)
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{}

      assert {:ok, %Message{} = message} = Chat.update_message(message, update_attrs)
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_message(message, @invalid_attrs)
      assert message == Chat.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Chat.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chat.change_message(message)
    end
  end

  describe "servers" do
    alias Drip.Chat.Server

    import Drip.ChatFixtures

    @invalid_attrs %{}

    test "list_servers/0 returns all servers" do
      server = server_fixture()
      assert Chat.list_servers() == [server]
    end

    test "get_server!/1 returns the server with given id" do
      server = server_fixture()
      assert Chat.get_server!(server.id) == server
    end

    test "create_server/1 with valid data creates a server" do
      valid_attrs = %{}

      assert {:ok, %Server{} = server} = Chat.create_server(valid_attrs)
    end

    test "create_server/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_server(@invalid_attrs)
    end

    test "update_server/2 with valid data updates the server" do
      server = server_fixture()
      update_attrs = %{}

      assert {:ok, %Server{} = server} = Chat.update_server(server, update_attrs)
    end

    test "update_server/2 with invalid data returns error changeset" do
      server = server_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_server(server, @invalid_attrs)
      assert server == Chat.get_server!(server.id)
    end

    test "delete_server/1 deletes the server" do
      server = server_fixture()
      assert {:ok, %Server{}} = Chat.delete_server(server)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_server!(server.id) end
    end

    test "change_server/1 returns a server changeset" do
      server = server_fixture()
      assert %Ecto.Changeset{} = Chat.change_server(server)
    end
  end

  describe "servers" do
    alias Drip.Chat.Membership

    import Drip.ChatFixtures

    @invalid_attrs %{}

    test "list_servers/0 returns all servers" do
      membership = membership_fixture()
      assert Chat.list_servers() == [membership]
    end

    test "get_membership!/1 returns the membership with given id" do
      membership = membership_fixture()
      assert Chat.get_membership!(membership.id) == membership
    end

    test "create_membership/1 with valid data creates a membership" do
      valid_attrs = %{}

      assert {:ok, %Membership{} = membership} = Chat.create_membership(valid_attrs)
    end

    test "create_membership/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_membership(@invalid_attrs)
    end

    test "update_membership/2 with valid data updates the membership" do
      membership = membership_fixture()
      update_attrs = %{}

      assert {:ok, %Membership{} = membership} = Chat.update_membership(membership, update_attrs)
    end

    test "update_membership/2 with invalid data returns error changeset" do
      membership = membership_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_membership(membership, @invalid_attrs)
      assert membership == Chat.get_membership!(membership.id)
    end

    test "delete_membership/1 deletes the membership" do
      membership = membership_fixture()
      assert {:ok, %Membership{}} = Chat.delete_membership(membership)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_membership!(membership.id) end
    end

    test "change_membership/1 returns a membership changeset" do
      membership = membership_fixture()
      assert %Ecto.Changeset{} = Chat.change_membership(membership)
    end
  end

  describe "servers" do
    alias Drip.Chat.Channel

    import Drip.ChatFixtures

    @invalid_attrs %{}

    test "list_servers/0 returns all servers" do
      channel = channel_fixture()
      assert Chat.list_servers() == [channel]
    end

    test "get_channel!/1 returns the channel with given id" do
      channel = channel_fixture()
      assert Chat.get_channel!(channel.id) == channel
    end

    test "create_channel/1 with valid data creates a channel" do
      valid_attrs = %{}

      assert {:ok, %Channel{} = channel} = Chat.create_channel(valid_attrs)
    end

    test "create_channel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_channel(@invalid_attrs)
    end

    test "update_channel/2 with valid data updates the channel" do
      channel = channel_fixture()
      update_attrs = %{}

      assert {:ok, %Channel{} = channel} = Chat.update_channel(channel, update_attrs)
    end

    test "update_channel/2 with invalid data returns error changeset" do
      channel = channel_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_channel(channel, @invalid_attrs)
      assert channel == Chat.get_channel!(channel.id)
    end

    test "delete_channel/1 deletes the channel" do
      channel = channel_fixture()
      assert {:ok, %Channel{}} = Chat.delete_channel(channel)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_channel!(channel.id) end
    end

    test "change_channel/1 returns a channel changeset" do
      channel = channel_fixture()
      assert %Ecto.Changeset{} = Chat.change_channel(channel)
    end
  end
end
