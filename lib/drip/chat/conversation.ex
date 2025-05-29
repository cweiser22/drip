defmodule Drip.Chat.Segment do
  alias Drip.Chat.Message
  alias Drip.Accounts.User

  @spec is_divider({atom(), any()}) :: boolean()
  def is_divider(segment) do
    match?({:divider, _}, segment)
  end

  @spec is_message_group({atom(), any()}) :: boolean()
  def is_message_group(segment) do
    match?({:message_group, _}, segment)
  end

  @spec build_segment(%{:__struct__ => Date | Message, optional(any()) => any()}) ::
          {:divider, Date.t()} | {:message_group, %{messages: [Message.t()], sender: User.t()}}
  def build_segment(message_or_divider_date) do
    case message_or_divider_date do
      %Message{} ->
        {:message_group,
         %{messages: [message_or_divider_date], sender: message_or_divider_date.sender}}

      %Date{} ->
        {:divider, message_or_divider_date}
    end
  end

  def add_message_to_group(segment, message) do
    data =
      case segment do
        {:message_group, data} ->
          Map.update(data, :messages, [message], fn messages -> data.messages ++ [message] end)

        {:divider, _} ->
          raise ArgumentError, message: "Cannot add message to a divider"

        _ ->
          raise ArgumentError, message: "Unknown segment type"
      end

    {:message_group, data}
  end
end

defmodule Drip.Chat.Conversation do
  alias Drip.Chat.Segment
  alias Drip.Chat.Message

  defstruct segments: [], last_message: nil

  @spec build_from_messages(any()) :: any()
  def build_from_messages(raw_messages) do
    conversation = %__MODULE__{}

    Enum.reduce(raw_messages, conversation, fn message, conversation ->
      conversation
      |> new_message(message)
      |> Map.put(:last_message, message)
    end)
  end

  def new_message(conversation, message) do
    conversation =
      if Map.get(conversation, :last_message, nil) != nil do
        if NaiveDateTime.to_date(message.inserted_at) ==
             NaiveDateTime.to_date(conversation.last_message.inserted_at) do
          if message.sender.id == conversation.last_message.sender.id do
            # TODO: fix duplicated segment
            conversation
            |> Map.update(:segments, [], fn segments ->
              segments ++ [Segment.add_message_to_group(Enum.at(segments, -1), message)]
            end)
          else
            # TODO: put message in new segment and add
            new_segment = Segment.build_segment(message)

            conversation
            |> Map.update(:segments, [], fn segments ->
              segments ++
                [Segment.build_segment(NaiveDateTime.to_date(message.inserted_at)), new_segment]
            end)
          end
        else
          conversation
          |> Map.update(:segments, [], fn segments ->
            segments ++
              [
                Segment.build_segment(NaiveDateTime.to_date(message.inserted_at)),
                Segment.build_segment(message)
              ]
          end)
        end
      else
        # TODO: add time divider then new segment
        conversation
        |> Map.update(:segments, [], fn segments ->
          segments ++
            [
              Segment.build_segment(NaiveDateTime.to_date(message.inserted_at)),
              Segment.build_segment(message)
            ]
        end)
      end

    conversation |> Map.put(:last_message, message)
  end

  def pretty_print_segments(conversation) do
    for s <- conversation.segments do
      case s do
        {:divider, date} ->
          IO.puts("Divider for #{date}")

        {:message_group, %{sender: sender, messages: messages}} ->
          IO.puts("#{length(messages)} sent by #{sender.email}")

        _ ->
          raise ArgumentError, message: "Invalid segment type"
      end
    end
  end
end
