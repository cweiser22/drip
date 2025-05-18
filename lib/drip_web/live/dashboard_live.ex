defmodule DripWeb.DashboardLive do
  alias Drip.Chat
  alias Drip.Chat.Server
  alias Drip.Chat.Channel
  alias Drip.Chat.Message
  alias Drip.Repo
  use DripWeb, :live_view
  import DripWeb.Components.NewMessage
  import DripWeb.Components.Conversation



  alias Drip.Accounts



  def mount(_params, %{"user_token" => token}, socket) do
    user = Accounts.get_user_by_session_token(token)
    servers = Drip.Repo.preload(user, :joined_servers).joined_servers

    current_server =
      case servers do
        [first | _] -> Repo.preload(first, [:channels])
        _ -> %Server{id: 0}
      end

    current_channel = if length(current_server.channels) > 0 do Enum.at(current_server.channels, 0) |> Repo.preload([:messages]) else 0 end

    {:ok, assign(socket, user: user, servers: servers, current_server: current_server,  current_channel: current_channel)}
  end

  def handle_event("select_server", %{"server_id" => server_id}, socket) do
    current_server = Chat.get_server(server_id) |> Repo.preload([:channels])
    current_channel = if length(current_server.channels) > 0 do Enum.at(current_server.channels, 0) |> Repo.preload([:messages]) else %Channel{id: 0} end

    # TODO: rewrite this correctly
    {:noreply, assign(socket, current_server: current_server, current_channel: current_channel)}
  end

  def handle_event("select_channel", %{"channel_id" => channel_id}, socket) do
    current_channel = Chat.get_channel(channel_id) |> Repo.preload([:messages])
    {:noreply, assign(socket, current_channel: current_channel)}
  end





  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
      <%= if @current_server.id != 0 do %>

      <%= if @current_channel.id != 0 do %>
        <div class="flex flex-col h-full w-full justify-start">
          <div class="p-4 border-b font-bold">
            #{@current_channel.name}
          </div>
          <div class="bg-gray-700 flex-1">

            <.conversation module={DripWeb.Components.Conversation} id="conversation" messages={@current_channel.messages} />

          </div>
          <div class="bg-indigo-100 h-16">

              <.live_component user={@user} current_channel={@current_channel} form={to_form(Message.create_changeset(%Message{}, %{}))} id="new-message-input" module={DripWeb.Components.NewMessage}></.live_component>

          </div>
        </div>
      <% end %>
      Current server is {@current_server.id}
      Current channel is {@current_channel.id}

      <% end %>
    """
  end
end
