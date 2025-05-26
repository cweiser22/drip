defmodule DripWeb.Components.ServerSidebar do
  use Phoenix.LiveComponent
  alias Drip.Accounts.User
  use DripWeb, :html

  def mount(socket) do
    {:ok, assign(socket, new_server_modal_open: false)}
  end

  def handle_event("open_modal", %{"value" => ""}, socket) do
    IO.inspect(socket.assigns.new_server_modal_open)
    socket = socket |> assign(new_server_modal_open: true)
    IO.inspect(socket.assigns.new_server_modal_open)
    {:noreply, socket}
  end

  def handle_event("close_modal", %{"value" => ""}, socket) do
    IO.inspect(socket.assigns.new_server_modal_open)
    socket = socket |> assign(new_server_modal_open: false)
    IO.inspect(socket.assigns.new_server_modal_open)
    {:noreply, socket}
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

  defmodule MessageGroup do
    defstruct messages: [], sender: %User{id: 0}
  end

  def render(assigns) do
    ~H"""
    <div class="w-20 flex flex-col items-center justify-start h-full bg-gray-900">
      <ul class="flex list-none flex-col flex-1 items-center justify-start w-full mt-4">
        <%= for server <- @servers do %>
          <.server_item current_server={@current_server} server={server}></.server_item>
        <% end %>
        <li class="aspect-square flex flex-col items-center justify-center list-none w-full pl-1">
          <button
            class="w-11 h-11 rounded-xl overflow-hidden "
            phx-click="open_modal"
            phx-target={@myself}
          >
            <.icon name="hero-plus" />
          </button>
          <.modal show={true} id="new-server-modal" on_cancel={JS.push("close_modal")}>
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
