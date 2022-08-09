defmodule Pento.Repo.Migrations.CreateFaqs do
  use Ecto.Migration

  def change do
    create table(:faqs) do
      add :username, :string
      add :questions, :string
      add :answers, :string
      add :likes_count, :integer

      timestamps()
    end
  end
end
