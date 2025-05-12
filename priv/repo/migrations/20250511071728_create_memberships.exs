defmodule Drip.Repo.Migrations.CreateMemberships do
  use Ecto.Migration

  def change do
    create table(:memberships) do
      add :user_id, references(:users, on_delete: :nothing)
      add :server_id, references(:servers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:memberships, [:user_id])
    create index(:memberships, [:server_id])
  end
end
