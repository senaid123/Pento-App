defmodule PentoWeb.FAQLiveTest do
  use PentoWeb.ConnCase

  import Phoenix.LiveViewTest
  import Pento.FAQSFixtures

  @create_attrs %{answers: "some answers", likes_count: 42, questions: "some questions", username: "some username"}
  @update_attrs %{answers: "some updated answers", likes_count: 43, questions: "some updated questions", username: "some updated username"}
  @invalid_attrs %{answers: nil, likes_count: nil, questions: nil, username: nil}

  defp create_faq(_) do
    faq = faq_fixture()
    %{faq: faq}
  end

  describe "Index" do
    setup [:create_faq]

    test "lists all faqs", %{conn: conn, faq: faq} do
      {:ok, _index_live, html} = live(conn, Routes.faq_index_path(conn, :index))

      assert html =~ "Listing Faqs"
      assert html =~ faq.answers
    end

    test "saves new faq", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.faq_index_path(conn, :index))

      assert index_live |> element("a", "New Faq") |> render_click() =~
               "New Faq"

      assert_patch(index_live, Routes.faq_index_path(conn, :new))

      assert index_live
             |> form("#faq-form", faq: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#faq-form", faq: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.faq_index_path(conn, :index))

      assert html =~ "Faq created successfully"
      assert html =~ "some answers"
    end

    test "updates faq in listing", %{conn: conn, faq: faq} do
      {:ok, index_live, _html} = live(conn, Routes.faq_index_path(conn, :index))

      assert index_live |> element("#faq-#{faq.id} a", "Edit") |> render_click() =~
               "Edit Faq"

      assert_patch(index_live, Routes.faq_index_path(conn, :edit, faq))

      assert index_live
             |> form("#faq-form", faq: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#faq-form", faq: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.faq_index_path(conn, :index))

      assert html =~ "Faq updated successfully"
      assert html =~ "some updated answers"
    end

    test "deletes faq in listing", %{conn: conn, faq: faq} do
      {:ok, index_live, _html} = live(conn, Routes.faq_index_path(conn, :index))

      assert index_live |> element("#faq-#{faq.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#faq-#{faq.id}")
    end
  end

  describe "Show" do
    setup [:create_faq]

    test "displays faq", %{conn: conn, faq: faq} do
      {:ok, _show_live, html} = live(conn, Routes.faq_show_path(conn, :show, faq))

      assert html =~ "Show Faq"
      assert html =~ faq.answers
    end

    test "updates faq within modal", %{conn: conn, faq: faq} do
      {:ok, show_live, _html} = live(conn, Routes.faq_show_path(conn, :show, faq))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Faq"

      assert_patch(show_live, Routes.faq_show_path(conn, :edit, faq))

      assert show_live
             |> form("#faq-form", faq: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#faq-form", faq: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.faq_show_path(conn, :show, faq))

      assert html =~ "Faq updated successfully"
      assert html =~ "some updated answers"
    end
  end
end
