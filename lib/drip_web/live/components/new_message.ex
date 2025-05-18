defmodule DripWeb.Components.NewMessage do
  use Phoenix.LiveComponent
  use DripWeb, :html
  alias Drip.Chat
  alias Drip.Chat.Message

  def handle_event("send_message", %{"message"=> %{"body" => body}}, socket) do
    sender_id = socket.assigns.user.id
    channel_id = socket.assigns.current_channel.id

    case Chat.create_message(%{"body" => body, "sender_id" => sender_id, "channel_id" => channel_id}) do
      {:ok, _message} ->
        {:noreply,
         socket
         |> assign(:form, to_form(%Message{} |>Message.create_changeset(%{body: ""})))}
         |> assign(:messa)

      {:error, changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end


  def render(assigns) do
    ~H"""
    <div class="w-full">
    <.form for={@form} as={:message} class="w-full" phx-submit="send_message" phx-target={@myself}>
    <div class="w-full p-3 flex flex-row space-x-4">

            <.input field={@form[:body]} autocomplete="off" type="text" class="bg-gray-50 border flex-1 border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 p-2.5 " placeholder="New message..." required />
            <button class="btn w-12 bg-teal-800 text-white rounded-lg" type="submit">
            Send
            </button>
    </div>

    </.form>
    </div>
    """

  end
end
