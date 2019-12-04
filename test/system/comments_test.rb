# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    login_user(user_email: "user_1@mail", password: "111111")
  end

  test "コメントが表示される" do
    visit book_path(id: books(:book_1))
    assert has_css?(".comment")
  end

  test "新規コメントを投稿できる" do
    visit book_path(id: books(:book_1))
    fill_in I18n.t("comments.form.comment"), with: "てすとこめんと"
    click_on "commit"
    assert_text "てすとこめんと"
  end

  test "自分が投稿したコメントを編集できる" do
    visit book_path(id: books(:book_2))
    fill_in I18n.t("comments.form.comment"), with: "編集前"
    click_on "commit"
    within("div.comments", visible: :false) do
      click_on I18n.t("comments.list.edit")
    end
    fill_in I18n.t("comments.form.comment"), with: "編集後"
    click_on "commit"
    assert_text "編集後"
  end

  test "自分が投稿したコメントを削除できる" do
    visit book_path(id: books(:book_2))
    fill_in I18n.t("comments.form.comment"), with: "これを消したい"
    click_on "commit"
    within("div.comments", visible: :false) do
      page.accept_confirm do
        click_on I18n.t("comments.list.delete")
      end
    end
    assert_text "これを消したい", count: 0
  end

  test "自分が投稿したコメントにのみ編集リンクが表示される" do
    visit book_path(id: books(:book_1))
    within("div.comments", visible: :false) do
      @num_of_edit_links = find_all(:link, I18n.t("comments.list.edit")).count
    end
    assert_equal 1, @num_of_edit_links
  end

  test "自分が投稿したコメントにのみ削除リンクが表示される" do
    visit book_path(id: books(:book_1))
    within("div.comments", visible: :false) do
      @num_of_delete_links = find_all(:link, I18n.t("comments.list.delete")).count
    end
    assert_equal 1, @num_of_delete_links
  end
end
