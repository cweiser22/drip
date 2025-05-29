defmodule Drip.ConversationStateTest do
  use Drip.DataCase

  alias Drip.Chat
  alias Drip.Chat.Conversation
  import Drip.Factory

  describe "conversation_state" do
    test "build conversation" do
      server = insert(:server)
      channel = insert(:channel, server: server, server_id: server.id)

      users = for _ <- 1..3, do: insert(:user)

      now = NaiveDateTime.utc_now()

      # Helper to shift the timestamp
      get_fake_datetime = fn ->
        # Spread over 3 days: 0 (today), 1, or 2 days ago
        days_ago = Enum.random(0..2)
        # random time in the day
        seconds_offset = Enum.random(0..86_399)
        NaiveDateTime.add(NaiveDateTime.add(now, -days_ago * 86_400), -seconds_offset)
      end

      for _ <- 1..50 do
        insert(:message,
          channel: channel,
          sender: Enum.random(users),
          inserted_at: get_fake_datetime.()
        )
      end

      messages = Chat.load_messages_for_channel(channel)

      assert length(messages) == 50

      conversation = Conversation.build_from_messages(messages)

      Conversation.pretty_print_segments(conversation)
    end
  end

  test "add messages to empty conversation" do
    conversation =
      %Conversation{}
      |> Conversation.new_message(build(:message))
      |> Conversation.new_message(build(:message))
      |> Conversation.new_message(build(:message))
      |> Conversation.new_message(build(:message))
      |> Conversation.new_message(build(:message))

    IO.inspect(conversation)
  end
end
