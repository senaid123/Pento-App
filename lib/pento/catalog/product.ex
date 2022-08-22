defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pento.Survey.Rating

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float
    field :image_upload, :string
    timestamps()
    has_many :ratings, Rating
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> validate_number(:unit_price, greater_than: 0)
    |> unique_constraint(:sku)
  end

  def price_changeset(changeset, operat, amount \\ 0) do
    changeset
    |> change_price(operat, amount)
  end

  defp change_price(changeset, operat, amount \\ 0) do
    prod_price = get_field(changeset, :unit_price)

    real_amount =
      if amount < 0 do
        amount * -1
      else
        amount
      end

    case operat do
      :decrease ->
        if prod_price - real_amount > 0 do
          put_change(changeset, :unit_price, prod_price - real_amount)
        else
          changeset
        end

      :increase ->
        put_change(changeset, :unit_price, prod_price + real_amount)
    end
  end
end
