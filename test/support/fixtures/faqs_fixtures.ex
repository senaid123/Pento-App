defmodule Pento.FAQSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.FAQS` context.
  """

  @doc """
  Generate a faq.
  """
  def faq_fixture(attrs \\ %{}) do
    {:ok, faq} =
      attrs
      |> Enum.into(%{
        answers: "some answers",
        likes_count: 42,
        questions: "some questions",
        username: "some username"
      })
      |> Pento.FAQS.create_faq()

    faq
  end
end
