defmodule DripWeb.DashboardLive do
  alias Drip.Chat
  alias Drip.Chat.Server
  alias Drip.Chat.Channel
  alias Drip.Chat.Message
  alias Drip.Repo
  use DripWeb, :live_view

  alias Drip.Accounts

  def switch_channel(old_channel_id, new_channel_id) do
    Phoenix.PubSub.unsubscribe(Drip.PubSub, "channel:#{old_channel_id}")
    Phoenix.PubSub.subscribe(Drip.PubSub, "channel:#{new_channel_id}")
  end

  def mount(_params, %{"user_token" => token}, socket) do
    user = Accounts.get_user_by_session_token(token)
    servers = Drip.Repo.preload(user, :joined_servers).joined_servers

    current_server =
      case servers do
        [first | _] -> Repo.preload(first, [:channels])
        _ -> %Server{id: 0, channels: []}
      end

    current_channel =
      if length(current_server.channels) > 0 do
        Enum.at(current_server.channels, 0) |> Repo.preload([:messages])
      else
        %Channel{id: 0}
      end


    """
    messages =
      if current_channel.id != 0 do
        Chat.load_messages_for_channel(current_channel)
      else
        []
      end
    """

    messages = %{}

    if current_channel.id != 0 do
      messages
    end

    if connected?(socket),
      do: switch_channel("", current_channel.id)

    {:ok,
     assign(socket,
       user: user,
       servers: servers,
       current_server: current_server,
       current_channel: current_channel,
       messages: messages,
       show_new_server_modal: false
     )}
  end

  def handle_info({:receive_message, message}, socket) do
    {:noreply, update(socket, :messages, fn messages -> messages ++ [message] end)}
  end

  def handle_info({:send_message, %{"body" => body}}, socket) do
    sender_id = socket.assigns.user.id
    channel_id = socket.assigns.current_channel.id

    with {:ok, message} <-
           Chat.create_message(%{
             "body" => body,
             "sender_id" => sender_id,
             "channel_id" => channel_id
           }) do
      message = Repo.preload(message, [:sender])
      Phoenix.PubSub.broadcast(Drip.PubSub, "channel:#{channel_id}", {:receive_message, message})
    end

    {:noreply,
     assign(socket, :form, to_form(%Message{} |> Message.create_changeset(%{body: ""})))}
  end

  def handle_event("select_server", %{"server_id" => server_id}, socket) do
    current_server = Chat.get_server(server_id) |> Repo.preload([:channels])

    old_channel = current_server

    current_channel =
      if length(current_server.channels) > 0 do
        Enum.at(current_server.channels, 0) |> Repo.preload([:messages])
      else
        %Channel{id: 0}
      end

    switch_channel(old_channel.id, current_channel.id)

    messages = Chat.load_messages_for_channel(current_channel)

    {:noreply,
     assign(socket,
       current_server: current_server,
       current_channel: current_channel,
       messages: messages
     )}
  end

  def handle_event("select_channel", %{"channel_id" => channel_id}, socket) do
    old_channel = socket.assigns.current_channel
    Phoenix.PubSub.unsubscribe(Drip.PubSub, "channel:#{old_channel.id}")
    current_channel = Chat.get_channel(channel_id)
    messages = Chat.load_messages_for_channel(current_channel)

    Phoenix.PubSub.subscribe(Drip.PubSub, "channel:#{current_channel.id}")
    switch_channel(old_channel.id, current_channel.id)
    {:noreply, assign(socket, current_channel: current_channel, messages: messages)}
  end

  def handle_event("open_modal", %{"value" => ""}, socket) do
    IO.puts("open modal")
    {:noreply, assign(socket, show_new_server_modal: true)}
  end

  def handle_event("close_modal", %{"value" => ""}, socket) do
    {:noreply, assign(socket, show_new_server_modal: false)}
  end

  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <%= if @current_server.id != 0 do %>
      <%= if @current_channel.id != 0 do %>
        <div class="flex flex-col h-full w-full justify-start">
          <!-- Channel name header -->
          <div class="flex flex-col justify-center p-4 border-b font-bold h-14 border-b font-bold bg-gray-800">
            <h4 class="text-sm">#{@current_channel.name}</h4>
          </div>

    <!-- scrollable messages list -->
          <div
            phx-hook="ScrollToBottom"
            class="bg-neutral-100 dark:bg-neutral-800 text-zinc-900 dark:text-zinc-200 flex-1 overflow-auto"
            id="conversation-scroll-container"
          >
            <.live_component
              module={DripWeb.Components.Conversation}
              current_user={@current_user}
              id="conversation"
              messages={@messages}
            />
          </div>

    <!-- new message form -->
          <div class="dark:bg-gray-800 bg-gray-800">
            <.live_component
              messages={@messages}
              user={@user}
              current_channel={@current_channel}
              form={to_form(Message.create_changeset(%Message{}, %{}))}
              id="new-message-input"
              module={DripWeb.Components.NewMessage}
            >
            </.live_component>
          </div>
        </div>
      <% end %>
    <% end %>
    """
  end
end
