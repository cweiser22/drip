defmodule Drip.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false
  alias Drip.Repo

  alias Drip.Chat.Message

  @spec get_message!(any()) :: none()
  @doc """
  Gets a single message.

  Raises if the Message does not exist.

  ## Examples

      iex> get_message!(123)
      %Message{}

  """
  def get_message!(id), do: raise("TODO")

  @spec get_message!(any()) :: none()
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

  @spec update_message(any(), any()) :: none()
  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, ...}

  """
  def update_message(%Message{} = message, attrs) do
    raise "TODO"
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
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Todo{...}

  """
  def change_message(%Message{} = message, _attrs \\ %{}) do
    raise "TODO"
  end

  alias Drip.Chat.Server

  @doc """
  Returns the list of servers.

  ## Examples

      iex> list_servers()
      [%Server{}, ...]

  """
  def list_servers do
    raise "TODO"
  end

  @doc """
  Gets a single server.

  Raises if the Server does not exist.

  ## Examples

      iex> get_server!(123)
      %Server{}

  """
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

      server ->
        Repo.delete(server)
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
    |> Repo.update()
  end

  alias Drip.Chat.Membership

  @doc """
  Returns the list of servers.

  ## Examples

      iex> list_servers()
      [%Membership{}, ...]

  """
  def list_servers do
    raise "TODO"
  end

  @doc """
  Gets a single membership.

  Raises if the Membership does not exist.

  ## Examples

      iex> get_membership!(123)
      %Membership{}

  """
  def get_membership!(id), do: raise("TODO")

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

  @doc """
  Updates a membership.

  ## Examples

      iex> update_membership(membership, %{field: new_value})
      {:ok, %Membership{}}

      iex> update_membership(membership, %{field: bad_value})
      {:error, ...}

  """
  def update_membership(%Membership{} = membership, _attrs) do
    raise "TODO"
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
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking membership changes.

  ## Examples

      iex> change_membership(membership)
      %Todo{...}

  """
  def change_membership(%Membership{} = membership, _attrs \\ %{}) do
    raise "TODO"
  end

  alias Drip.Chat.Channel

  @doc """
  Returns the list of servers.

  ## Examples

      iex> list_servers()
      [%Channel{}, ...]

  """
  def list_servers do
    raise "TODO"
  end

  @doc """
  Gets a single channel.

  Raises if the Channel does not exist.

  ## Examples

      iex> get_channel!(123)
      %Channel{}

  """
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
  def add_channel(attrs \\ %{}) do
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
  def update_channel(%Channel{} = channel, _attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Channel.

  ## Examples

      iex> delete_channel(channel)
      {:ok, %Channel{}}

      iex> delete_channel(channel)
      {:error, ...}

  """
  def delete_channel(%Channel{} = _channel) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking channel changes.

  ## Examples

      iex> change_channel(channel)
      %Todo{...}

  """
  def change_channel(%Channel{} = channel, _attrs \\ %{}) do
    raise "TODO"
  end
end
