defmodule DripWeb.Components.Conversation do
  use Phoenix.LiveComponent

  def message(assigns) do
    hash =
      assigns.message.sender.email
      |> String.trim()
      |> String.downcase()
      |> :erlang.md5()
      |> Base.encode16(case: :lower)
    icon_url = "https://gravatar.com/avatar/#{hash}?d=identicon&s=200"

    ~H"""
    <div class="w-full flex flex-row py-4 px-4">
      <img class="inline-block size-6 rounded-full ring-1 w-11 h-11" src={icon_url}>
      <div class="flex-1 px-4">
        <h4 class="text-xs font-bold mb-1 text-zinc-300">{@message.sender.email}</h4>
        <h3>{@message.body}</h3>
      </div>
    </div>
    """
  end

  def conversation(assigns) do
    ~H"""
    <div class="text-white bg-gray-700 h-full space-y-2">
      <%= for message <- @messages do %>
      <.message message={message} />
      <% end %>
    </div>
    """
  end
end
