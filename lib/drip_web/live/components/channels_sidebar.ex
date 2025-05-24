defmodule DripWeb.Components.ChannelsSidebar do
  use Phoenix.LiveComponent
  use DripWeb, :html

  def channels_sidebar(assigns) do
    ~H"""
    <div class="w-full h-full bg-gray-900">
      <%= if @current_server do %>
        <div class="p-3 border-b font-bold">
          {@current_server.name}
        </div>
        <%= if @current_server.channels do %>
          <ul class="p-2">
            <%= for channel <- @current_server.channels do %>
              <li class="h-8 w-full">
                <button
                  class={"flex flex-row justify-start text-md font-bold text-zinc-300 items-center h-full w-full space-x-2 rounded-md p-2 " <> if @current_channel.id == channel.id, do: "bg-blue-500", else: ""}
                  phx-click="select_channel"
                  phx-value-channel_id={channel.id}
                >
                  <.icon name="hero-hashtag" />

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
