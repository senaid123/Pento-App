defmodule Pento.FAQSTest do
  use Pento.DataCase

  alias Pento.FAQS

  describe "faqs" do
    alias Pento.FAQS.FAQ

    import Pento.FAQSFixtures

    @invalid_attrs %{answers: nil, likes_count: nil, questions: nil, username: nil}

    test "list_faqs/0 returns all faqs" do
      faq = faq_fixture()
      assert FAQS.list_faqs() == [faq]
    end

    test "get_faq!/1 returns the faq with given id" do
      faq = faq_fixture()
      assert FAQS.get_faq!(faq.id) == faq
    end

    test "create_faq/1 with valid data creates a faq" do
      valid_attrs = %{answers: "some answers", likes_count: 42, questions: "some questions", username: "some username"}

      assert {:ok, %FAQ{} = faq} = FAQS.create_faq(valid_attrs)
      assert faq.answers == "some answers"
      assert faq.likes_count == 42
      assert faq.questions == "some questions"
      assert faq.username == "some username"
    end

    test "create_faq/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FAQS.create_faq(@invalid_attrs)
    end

    test "update_faq/2 with valid data updates the faq" do
      faq = faq_fixture()
      update_attrs = %{answers: "some updated answers", likes_count: 43, questions: "some updated questions", username: "some updated username"}

      assert {:ok, %FAQ{} = faq} = FAQS.update_faq(faq, update_attrs)
      assert faq.answers == "some updated answers"
      assert faq.likes_count == 43
      assert faq.questions == "some updated questions"
      assert faq.username == "some updated username"
    end

    test "update_faq/2 with invalid data returns error changeset" do
      faq = faq_fixture()
      assert {:error, %Ecto.Changeset{}} = FAQS.update_faq(faq, @invalid_attrs)
      assert faq == FAQS.get_faq!(faq.id)
    end

    test "delete_faq/1 deletes the faq" do
      faq = faq_fixture()
      assert {:ok, %FAQ{}} = FAQS.delete_faq(faq)
      assert_raise Ecto.NoResultsError, fn -> FAQS.get_faq!(faq.id) end
    end

    test "change_faq/1 returns a faq changeset" do
      faq = faq_fixture()
      assert %Ecto.Changeset{} = FAQS.change_faq(faq)
    end
  end
end
