defmodule Drip.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false
  alias Drip.Repo

  alias Drip.Chat.Message

  def get_message!(id) do
    Repo.get!(Message, id)
  end

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, ...}

  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.create_changeset(attrs)
    |> Repo.insert()
  end

  def load_messages_for_channel(channel) do
    messages =
      (channel
       |> Repo.preload(messages: from(m in Message, order_by: [asc: m.inserted_at]))).messages

    Repo.preload(messages, [:sender])
  end

  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, ...}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Message.

  ## Examples

      iex> delete_message(message)
      {:ok, %Message{}}

      iex> delete_message(message)
      {:error, ...}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns a data structure for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Todo{...}

  """
  def change_message(%Message{} = message, attrs \\ %{}) do
    message
    |> Message.update_changeset(attrs)
  end

  alias Drip.Chat.Server

  @doc """
  Returns the list of servers.

  ## Examples

      iex> list_servers()
      [%Server{}, ...]

  """
  def list_servers do
    Repo.all(Server)
  end

  @doc """
  Gets a single server.

  Raises if the Server does not exist.

  ## Examples

      iex> get_server!(123)
      %Server{}

  """
  def get_server!(id) do
    Repo.get!(Server, id)
  end

  def get_server(id) do
    Repo.get(Server, id)
  end

  def create_server(attrs \\ %{}) do
    %Server{}
    |> Server.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a server.

  ## Examples

      iex> update_server(server, %{field: new_value})
      {:ok, %Server{}}

      iex> update_server(server, %{field: bad_value})
      {:error, ...}

  """
  def update_server(%Server{} = server, attrs) do
    server
    |> Server.edit_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Server.

  ## Examples
  Chat.get_server(3) |> Chat.update_server(%{icon_url: "https://static.thenounproject.com/png/capybara-icon-599956-512.png"})

      iex> delete_server(server)
      {:ok, %Server{}}

      iex> delete_server(server)
      {:error, ...}

  """
  def delete_server(id) do
    case Repo.get(Server, id) do
      nil ->
        {:error, :not_found}

      %Server{} = server ->
        case Repo.delete(server) do
          {:ok, deleted_server} -> {:ok, deleted_server}
          {:error, changeset} -> {:error, changeset}
        end
    end
  end

  @doc """
  Returns a data structure for tracking server changes.

  ## Examples

      iex> change_server(server)
      %Todo{...}

  """
  def change_server(%Server{} = server, attrs \\ %{}) do
    server
    |> Server.edit_changeset(attrs)
  end

  alias Drip.Chat.Membership

  @doc """
  Gets a single membership.

  Raises if the Membership does not exist.

  ## Examples

      iex> get_membership!(123)
      %Membership{}

  """
  def get_membership!(id) do
    Repo.get!(Membership, id)
  end

  @doc """
  Creates a membership.

  ## Examples

      iex> create_membership(%{field: value})
      {:ok, %Membership{}}

      iex> create_membership(%{field: bad_value})
      {:error, ...}

  """
  def create_membership(attrs \\ %{}) do
    %Membership{}
    |> Membership.create_changeset(attrs)
    |> Repo.insert()
  end

  def update_membership(membership, attrs \\ %{}) do
    membership
    |> Membership.create_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Membership.

  ## Examples

      iex> delete_membership(membership)
      {:ok, %Membership{}}

      iex> delete_membership(membership)
      {:error, ...}

  """
  def delete_membership(%Membership{} = membership) do
    Repo.delete(membership)
  end

  def list_memberships do
    Repo.all(Membership)
  end

  @doc """
  Returns a data structure for tracking membership changes.

  ## Examples

      iex> change_membership(membership)
      %Todo{...}

  """
  def change_membership(%Membership{} = membership, attrs \\ %{}) do
    membership
    |> Membership.create_changeset(attrs)
  end

  alias Drip.Chat.Channel

  @doc """
  Gets a single channel.

  Raises if the Channel does not exist.

  ## Examples

      iex> get_channel!(123)
      %Channel{}

  """
  def get_channel!(id) do
    Repo.get!(Channel, id)
  end

  def get_channel(id) do
    Repo.get(Channel, id)
  end

  @doc """
  Creates a channel.

  ## Examples

      iex> create_channel(%{field: value})
      {:ok, %Channel{}}

      iex> create_channel(%{field: bad_value})
      {:error, ...}

  """
  def create_channel(attrs \\ %{}) do
    %Channel{}
    |> Channel.create_changeset(attrs)
    |> Repo.insert()
  end

  @spec update_channel(any(), any()) :: none()
  @doc """
  Updates a channel.

  ## Examples

      iex> update_channel(channel, %{field: new_value})
      {:ok, %Channel{}}

      iex> update_channel(channel, %{field: bad_value})
      {:error, ...}

  """
  def update_channel(%Channel{} = channel, attrs) do
    channel
    |> Channel.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Channel.

  ## Examples

      iex> delete_channel(channel)
      {:ok, %Channel{}}

      iex> delete_channel(channel)
      {:error, ...}

  """
  def delete_channel(%Channel{} = channel) do
    Repo.delete(channel)
  end

  @doc """
  Returns a data structure for tracking channel changes.

  ## Examples

      iex> change_channel(channel)
      %Todo{...}

  """
  def change_channel(%Channel{} = channel, attrs \\ %{}) do
    Channel.create_changeset(channel, attrs)
  end

  def list_channels() do
    Repo.all(Channel)
  end
end
