defmodule DripWeb.Components.ServerSidebar do
  use Phoenix.LiveComponent

  use DripWeb, :html

  def server_item(assigns) do
    ~H"""
    <li class={"py-2 flex flex-col items-center justify-center list-none w-full " <> if @current_server.id == @server.id, do: "border-l-4 box-border", else: ""}>
      <button
        class="w-10 h-10 rounded-xl overflow-hidden bg-white"
        phx-click="select_server"
        phx-value-server_id={@server.id}
      >
        <img src={@server.icon_url} class="w-full h-full object-cover" alt="Server Icon" />
      </button>
    </li>
    """
  end

  def divider(assigns) do
    ~H"""
    <div class="my-2 w-full px-4">
      <div class="w-full flex items-center">
        <div class="w-full border-t border-gray-300"></div>
      </div>
    </div>
    """
  end

  def render(assigns) do
    ~H"""
    <div class="w-18 flex flex-col items-center justify-start h-full bg-gray-850 border-white border-r box-border">
      <ul class="space-y-1 flex list-none flex-col flex-1 items-center justify-start w-full mt-4">
        <%= for server <- @servers do %>
          <.server_item current_server={@current_server} server={server}></.server_item>
        <% end %>
        <.divider></.divider>
        <li class="flex flex-col items-center justify-center list-none w-full pl-1">
          <button class="w-10 h-10 rounded-xl overflow-hidden " phx-click="open_modal">
            <.icon name="hero-plus" />
          </button>
          <.modal id="new-server-modal" show={@show_new_server_modal}>
            <div>
              This is the modal body.
            </div>
          </.modal>
        </li>
      </ul>
    </div>
    """
  end
end
