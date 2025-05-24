defmodule DripWeb.Components.ServerSidebar do
  use Phoenix.LiveComponent
  use DripWeb, :html

  def update(assigns, socket) do
    IO.inspect(assigns, label: "LiveComponent update/2 called with")

    socket =
      socket
      |> assign_new(:new_server_modal_open, fn -> false end)
      |> assign(assigns)

    {:ok, socket}
  end

  def server_item(assigns) do
    ~H"""
    <li class={" aspect-square flex flex-col items-center justify-center list-none w-full " <> if @current_server.id == @server.id, do: "border-l-4", else: "pl-1"}>
      <button
        class="w-11 h-11 rounded-xl overflow-hidden bg-white"
        phx-click="select_server"
        phx-value-server_id={@server.id}
      >
        <img src={@server.icon_url} class="w-full h-full object-cover" alt="Server Icon" />
      </button>
    </li>
    """
  end

  def server_sidebar(assigns) do
    ~H"""
    <div class="w-20 flex flex-col items-center justify-start h-full bg-grey-900">
      <ul class="flex list-none flex-col flex-1 items-center justify-start w-full mt-4">
        <%= for server <- @servers do %>
          <.server_item current_server={@current_server} server={server}></.server_item>
        <% end %>
        <li class="aspect-square flex flex-col items-center justify-center list-none w-full pl-1">
          <button class="w-11 h-11 rounded-xl overflow-hidden ">
            <.icon name="hero-plus" />
          </button>
          <.modal
            id="new-server-modal"
            show={@new_server_modal_open}
            on_cancel={JS.push("close_modal")}
          >
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
