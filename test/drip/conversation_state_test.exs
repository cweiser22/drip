defmodule Drip.ConversationStateTest do
  use Drip.DataCase

  alias Drip.Chat
  alias Drip.Chat.ConversationState
  import Drip.Factory

  describe "conversation_state" do
    test "make time divider with valid date" do
      assert {:divider, date} = ConversationState.build_time_divider(NaiveDateTime.utc_now())
    end

    test "add valid message to populated segment" do
      initial_segment =
        {:messages,
         %{
           sender: build(:user),
           messages: build_list(10, :message)
         }}

      new_message = build(:message)

      {:messages, %{messages: messages}} =
        ConversationState.add_message_to_segment(initial_segment, new_message)

      assert new_message.id in Enum.map(messages, fn m -> m.id end)
    end

    test "build conversation" do
      server = insert(:server)
      channel = insert(:channel, server: server, server_id: server.id)

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
          inserted_at: get_fake_datetime.()
        )
      end

      messages = Chat.load_messages_for_channel(channel)

      assert length(messages) == 50

      segmented_messages = ConversationState.segment_messages(messages)
      IO.inspect(segmented_messages)
      IO.puts(segmented_messages)
    end
  end
end
