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

  def get_icon_url_for_group(group) do
    get_icon_url(group.sender.email)
  end

  def message_group(assigns) do
    ~H"""
    <div class="w-full flex flex-row py-4 px-4">
      <img
        class="inline-block size-6 rounded-full ring-1 w-11 h-11"
        src={get_icon_url_for_group(@data)}
      />
      <div class="flex-1 px-4">
        <h4 class="text-cyan-700 dark:text-cyan-200 text-xs font-bold mb-1 text-zinc-300">
          {@data.sender.email}
        </h4>
        <%= for message <- @data.messages do %>
          <h3 class="mb-1">{message.body}</h3>
        <% end %>
      </div>
    </div>
    """
  end

  def message(assigns) do
    ~H"""
    <h3>{@message.body}</h3>
    """
  end

  def divider(assigns) do
    ~H"""
    <div class="relative flex items-center justify-center my-4">
      <div class="absolute inset-0 flex items-center" aria-hidden="true">
        <div class="w-full border-t border-gray-600"></div>
      </div>
      <div class="relative bg-gray-800 px-3 text-xs text-gray-400 font-medium rounded">
        {@date}
      </div>
    </div>
    """
  end

  def render(assigns) do
    ~H"""
    <div class="dark:text-white text-zinc-900 bg-neutral-100 dark:bg-neutral-800 h-full space-y-2">
      <%= for segment <- @conversation.segments do %>
        <%= case segment do %>
          <% {:divider, date} -> %>
            <.divider date={date}></.divider>
          <% {:message_group, data} -> %>
            <.message_group data={data}></.message_group>
        <% end %>
      <% end %>
    </div>
    """
  end
end
