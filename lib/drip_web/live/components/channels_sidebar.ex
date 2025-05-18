defmodule DripWeb.Components.ChannelsSidebar do
  use Phoenix.LiveComponent

  def channels_sidebar(assigns) do
    ~H"""
    <div class="w-64 h-full bg-grey-700">
      <%= if @current_server do %>
      <div class="p-4 border-b font-bold">
      {@current_server.name}
      </div>
        <%= if @current_server.channels do %>
        <ul class="p-4">
        <%= for channel <- @current_server.channels do %>
          <li class="h-8 w-full">
          <button class="flex flex-row justify-start items-center h-full w-full space-x-2" phx-click="select_channel" phx-value-channel_id={channel.id}>
            <img src="https://previews.123rf.com/images/fanisazahr/fanisazahr2103/fanisazahr210300180/166131558-hashtag-icon-hashtag-symbol-social-media-icon-vector-illustration-linear-black-hashtag-concept.jpg" class="w-4 h-4" />
            <span>{channel.name}</span>
            </button>
          </li>
        <% end %>
        </ul>
        <% end %>
      <% else %>
      No server selected
      <% end %>
    </div>
    """
  end
end
