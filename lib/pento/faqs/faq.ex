defmodule Pento.FAQS.FAQ do
  use Ecto.Schema
  import Ecto.Changeset

  schema "faqs" do
    field :answers, :string
    field :likes_count, :integer
    field :questions, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:username, :questions, :answers, :likes_count])
    |> validate_required([:username, :questions, :answers, :likes_count])
  end
end
