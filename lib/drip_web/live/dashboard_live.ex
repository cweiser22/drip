defmodule DripWeb.DashboardLive do
  use DripWeb, :live_view

  alias Drip.Accounts
  alias Drip.Chat.Server
  alias Drip.Chat.Membership
  alias Drip.Chat.Message
  alias Drip.Chat.Channel



  def mount(params, %{"user_token" => token}, socket) do
    user = Accounts.get_user_by_session_token(token)
    servers = Drip.Repo.preload(user, :joined_servers).joined_servers

    {:ok, assign(socket, user: user, servers: servers)}
  end

  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
      <h1 class="text-2xl font-bold">Dashboard</h1>
      <p>This will show data from several models: users, servers, channels, messages.</p>
    """
  end
end
