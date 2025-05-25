defmodule DripWeb.Components.Conversation do
  use Phoenix.LiveComponent

  def get_icon_url(email) do
    hash =
      email
      |> String.trim()
      |> String.downcase()
      |> :erlang.md5()
      |> Base.encode16(case: :lower)

    "https://gravatar.com/avatar/#{hash}?d=identicon&s=200"
  end

  def message_group(assigns) do
    icon_url = get_icon_url(Enum.at(assigns.group, 0).sender.email)

    ~H"""
    <div class="w-full flex flex-row py-4 px-4">
      <img class="inline-block size-6 rounded-full ring-1 w-11 h-11" src={icon_url} />
      <div class="flex-1 px-4">
        <h4 class="text-xs font-bold mb-1 text-zinc-300">{Enum.at(@group, 0).sender.email}</h4>
        <%= for message <- @group do %>
          <h3>{message.body}</h3>
        <% end %>
      </div>
    </div>
    """
  end

  def group_messages(messages) do
    message_groups =
      Enum.reduce(
        messages,
        %{prev: nil, groups: []},
        fn message, acc ->
          case acc.prev do
            nil ->
              %{prev: message, groups: [[message]]}

            _ ->
              if acc.prev.sender.id == message.sender.id do
                # TODO: rewrite this, as it's very inefficient
                groups = List.update_at(acc.groups, -1, fn last -> last ++ [message] end)
                %{prev: message, groups: groups}
              else
                groups = acc.groups ++ [[message]]
                %{prev: message, groups: groups}
              end
          end
        end
      )

    message_groups.groups
  end

  def message(assigns) do
    ~H"""
    <h3>{@message.body}</h3>
    """
  end

  def conversation(assigns) do
    message_groups = group_messages(assigns.messages)
    assigns = assign(assigns, :message_groups, message_groups)

    ~H"""
    <div class="text-white bg-gray-700 h-full space-y-2">
      <%= for group <- @message_groups do %>
        <.message_group group={group} current_user={@current_user} />
      <% end %>
    </div>
    """
  end
end
