defmodule DripWeb.Components.ServerSidebar do
  use Phoenix.LiveComponent

  def server_item(assigns) do
    ~H"""
    <li class={"w-12 h-12 list-none " <> if @current_server.id == @server.id, do: "border-l-4", else: "pl-1"}>
              <button class="block w-12 h-12 w-full h-full" phx-click="select_server" phx-value-server_id={@server.id} >
                <img
                  src={@server.icon_url}
                  class="rounded-full w-full h-full overflow-hidden object-cover"
                  alt="Server Icon"
                />
              </button>
            </li>
    """
  end


  def server_sidebar(assigns) do
    ~H"""
      <div class="w-20 flex flex-col items-center justify-start h-full bg-grey-900">
        <ul class="flex list-none flex-col flex-1 items-center justify-start w-full space-y-4 mt-4">
          <%= for server <- @servers do %>
          <.server_item current_server={@current_server} server={server}></.server_item>

          <% end %>
          <li class="p-2" >
              <button class="block w-12 h-12 overflow-hidden">
                <img class="rounded-full w-full h-full object-cover" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Plus_symbol.svg/1200px-Plus_symbol.svg.png"/>
              </button>
            </li>
        </ul>
      </div>
    """
  end
end
