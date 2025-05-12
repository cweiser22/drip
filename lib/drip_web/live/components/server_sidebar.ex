defmodule DripWeb.Components.ServerSidebar do
  use Phoenix.LiveComponent

  def server_sidebar(assigns) do
    ~H"""
      <div class="w-12 flex-col items-center justify-start h-full bg-red-500">
        <ul class="space-y-1">
          <%= for server <- @servers do %>
            <li>
              <img src={server.icon_url}/>
            </li>
          <%= end %>
        </ul>
      </div>

    """
  end
end
