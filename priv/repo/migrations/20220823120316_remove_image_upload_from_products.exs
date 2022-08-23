defmodule Pento.Repo.Migrations.RemoveImageUploadFromProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      remove :image_upload
    end
  end
end
