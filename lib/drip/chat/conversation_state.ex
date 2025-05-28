defmodule Drip.Chat.ConversationState do
  alias Drip.Chat.Message

  def add_conversation(conversations, server, channel, segmented_messages) do
    Map.put({server.id, channel.id}, segmented_messages)
  end

  def add_message(conversations, server, channel, message) do
    updated = update_in(conversations[{server.id, channel.id}], fn c -> c ++ [message] end)
    # Map.update(conversations, {server.id, channel.id}, )
  end

  # creates a new segment using an initial message
  def build_segment(first_message) do
    {:messages,
     %{
       sender: first_message.sender,
       messages: [first_message]
     }}
  end

  # adds a new message to an existing segment
  def add_message_to_segment({:messages, data = %{messages: messages}}, message) do
    {:messages, Map.put(data, :messages, messages ++ [message])}
  end

  @spec build_time_divider(any()) :: {:divider, any()}
  def build_time_divider(date) do
    {:divider, date}
  end

  def segment_messages(raw_messages) do
    result =
      Enum.reduce(raw_messages, %{prev: nil, segments: [], current_segment: nil}, fn m, acc ->
        acc =
          if acc.prev do
            if NaiveDateTime.to_date(m.inserted_at) != NaiveDateTime.to_date(acc.prev.inserted_at) do
              acc =
                acc
                |> Map.update!(:segments, fn segments -> segments ++ [acc.current_segment] end)
                |> Map.put(:segments, build_time_divider(NaiveDateTime.to_date(m.inserted_at)))
                |> Map.put(:current_segment, build_segment(m))

              acc
            else
              if m.sender.id == acc.prev.sender.id do
                {:messages, current_segment} = Enum.at(acc.segments, -1, {:messages, %{}})
                acc |> Map.put(:current_segment, add_message_to_segment(current_segment, m))
              else
                acc
                |> Map.update!(:segments, fn segments -> segments ++ [acc.current_segment] end)
                |> Map.put(:current_segment, build_segment(m))
              end
            end
          else
            acc
            |> Map.put(:segments, build_time_divider(NaiveDateTime.to_date(m.inserted_at)))
            |> Map.put(:current_segment, build_segment(m))
          end

        acc |> Map.put(:prev, m)
      end)

    Map.get(result, :segments)
  end
end
