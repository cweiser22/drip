defmodule DripWeb.Components.Conversation do
  use Phoenix.LiveComponent

  def message(assigns) do
    ~H"""
    <div class="w-full p-4 text-md">
      <h3>{@body}</h3>
    </div>
    """
  end

  def conversation(assigns) do
    ~H"""
    <div class="h-full w-full overflow-y-auto text-white bg-gray-700">
      <%= for message <- @messages do %>
      <.message body={message.body} />
      <% end %>
    </div>
    """
  end
end
