defmodule DripWeb.Components.NewMessage do
  use Phoenix.LiveComponent
  use DripWeb, :html

  alias Drip.Chat.Message

  def handle_event("send_message", %{"message" => message}, socket) do
    send(self(), {:send_message, message})

    IO.puts("send message activated in")

    {:noreply,
     assign(socket, :form, to_form(%Message{} |> Message.create_changeset(%{body: ""})))}
  end

  def render(assigns) do
    ~H"""
    <div class="w-full h-full ">
      <.form
        for={@form}
        as={:message}
        class="w-full h-full p-2"
        phx-submit="send_message"
        phx-target={@myself}
      >
        <div class="w-full flex flex-row items-center space-x-2">
          <.input
            container_classes="w-full "
            field={@form[:body]}
            autocomplete="off"
            type="text"
            class="bg-gray-850 border flex-1 border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 "
            placeholder="New message..."
            required
          />
        </div>
      </.form>
    </div>
    """
  end
end
