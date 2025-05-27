defmodule Drip.ChatTest do
  use Drip.DataCase

  alias Drip.Chat
  import Drip.Factory

  describe "messages" do
    alias Drip.Chat.Message
    @invalid_attrs %{}

    test "create_message/1 with valid data creates a message" do
      attrs = params_for(:message)
      assert {:ok, %Message{} = message} = Chat.create_message(attrs)
      assert message.body == attrs.body
      refute is_nil(message.sender_id)
      refute is_nil(message.channel_id)
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = insert(:message)
      update_attrs = %{body: "Updated message!"}
      assert {:ok, %Message{} = updated} = Chat.update_message(message, update_attrs)
      assert updated.body == "Updated message!"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = insert(:message)

      nil_body = %{body: nil}

      assert {:error, %Ecto.Changeset{}} = Chat.update_message(message, nil_body)
      assert Chat.get_message!(message.id).body == message.body
    end

    test "delete_message/1 deletes the message" do
      message = insert(:message)
      assert {:ok, %Message{}} = Chat.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = insert(:message)
      assert %Ecto.Changeset{} = Chat.change_message(message)
    end
  end

  describe "servers" do
    alias Drip.Chat.Server
    @invalid_attrs %{}

    test "list_servers/0 returns all servers" do
      server = insert(:server)
      [returned_server] = Chat.list_servers()
      assert returned_server.id == server.id
    end

    test "get_server!/1 returns the server with given id" do
      server = insert(:server)
      assert Chat.get_server!(server.id).id == server.id
    end

    test "create_server/1 with valid data creates a server" do
      attrs = params_for(:server)
      assert {:ok, %Server{} = server} = Chat.create_server(attrs)
      assert server.name == attrs.name
    end

    test "create_server/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_server(@invalid_attrs)
    end

    test "update_server/2 with valid data updates the server" do
      server = insert(:server)
      update_attrs = %{name: "Updated server"}
      assert {:ok, %Server{} = server} = Chat.update_server(server, update_attrs)
      assert server.name == "Updated server"
    end

    test "update_server/2 with invalid data returns error changeset" do
      server = insert(:server)

      invalid_update_attrs = %{
        name: nil
      }

      assert {:error, %Ecto.Changeset{}} = Chat.update_server(server, invalid_update_attrs)
      assert server.name == Chat.get_server!(server.id).name
    end

    test "delete_server/1 deletes the server" do
      server = insert(:server)
      assert {:ok, server} = Chat.delete_server(server.id)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_server!(server.id) end
    end

    test "change_server/1 returns a server changeset" do
      server = insert(:server)
      assert %Ecto.Changeset{} = Chat.change_server(server)
    end
  end

  describe "memberships" do
    alias Drip.Chat.Membership
    @invalid_attrs %{}

    test "list_memberships/0 returns all memberships" do
      membership = insert(:membership)
      [returned_membership] = Chat.list_memberships()
      assert returned_membership.id == membership.id
    end

    test "get_membership!/1 returns the membership with given id" do
      membership = insert(:membership)
      assert Chat.get_membership!(membership.id).id == membership.id
    end

    test "create_membership/1 with valid data creates a membership" do
      attrs = params_for(:membership)
      assert {:ok, %Membership{} = membership} = Chat.create_membership(attrs)
      refute is_nil(membership.user_id)
      refute is_nil(membership.server_id)
    end

    test "create_membership/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_membership(@invalid_attrs)
    end

    test "update_membership/2 with valid data updates the membership" do
      membership = insert(:membership)
      update_attrs = %{}
      assert {:ok, %Membership{} = _updated} = Chat.update_membership(membership, update_attrs)
    end

    test "update_membership/2 with invalid data returns error changeset" do
      membership = insert(:membership)
      invalid_update_attrs = %{server_id: nil, user_id: nil}

      assert {:error, %Ecto.Changeset{}} =
               Chat.update_membership(membership, invalid_update_attrs)

      assert membership.server_id == Chat.get_membership!(membership.id).server_id
      assert membership.user_id == Chat.get_membership!(membership.id).user_id
    end

    test "delete_membership/1 deletes the membership" do
      membership = insert(:membership)
      assert {:ok, %Membership{}} = Chat.delete_membership(membership)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_membership!(membership.id) end
    end

    test "change_membership/1 returns a membership changeset" do
      membership = insert(:membership)
      assert %Ecto.Changeset{} = Chat.change_membership(membership)
    end
  end

  describe "channels" do
    alias Drip.Chat.Channel
    @invalid_attrs %{}

    test "list_channels/0 returns all channels" do
      channel = insert(:channel)
      [returned_channel] = Chat.list_channels()
      assert returned_channel.id == channel.id
    end

    test "get_channel!/1 returns the channel with given id" do
      channel = insert(:channel)
      assert Chat.get_channel!(channel.id).id == channel.id
      assert Chat.get_channel!(channel.id).name == channel.name
    end

    test "create_channel/1 with valid data creates a channel" do
      attrs = params_for(:channel)
      assert {:ok, %Channel{} = channel} = Chat.create_channel(attrs)
      assert channel.name == attrs.name
    end

    test "create_channel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_channel(@invalid_attrs)
    end

    test "update_channel/2 with valid data updates the channel" do
      channel = insert(:channel)
      update_attrs = %{name: "updated-channel"}
      assert {:ok, %Channel{} = updated} = Chat.update_channel(channel, update_attrs)
      assert updated.name == "updated-channel"
    end

    test "update_channel/2 with invalid data returns error changeset" do
      channel = insert(:channel)
      invalid_update_attrs = %{name: nil}
      assert {:error, %Ecto.Changeset{}} = Chat.update_channel(channel, invalid_update_attrs)
      assert channel.name == Chat.get_channel!(channel.id).name
    end

    test "delete_channel/1 deletes the channel" do
      channel = insert(:channel)
      assert {:ok, %Channel{}} = Chat.delete_channel(channel)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_channel!(channel.id) end
    end

    test "change_channel/1 returns a channel changeset" do
      channel = insert(:channel)
      assert %Ecto.Changeset{} = Chat.change_channel(channel)
    end
  end
end
