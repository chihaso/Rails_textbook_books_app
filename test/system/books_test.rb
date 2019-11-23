# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    login_user(user_email: "user_1@mail", password: "111111")
  end

  test "書籍一覧ページを表示できる" do
    visit books_url
    assert_selector "h1", text: I18n.t("books_app.page_title.index")
  end

  test "新規に書籍を登録できる" do
    visit books_url
    click_on I18n.t("books_app.new_book")

    fill_in "Title", with: "面白い本"
    fill_in "Memo", with: "とても面白い"
    fill_in "Author", with: "城井 重"

    click_on "commit"
    assert_text I18n.t("books_app.notice.success.create")
  end

  test "書籍情報ページを表示できる" do
    visit books_url
    click_on I18n.t("books_app.show"), match: :first
    assert_selector "h1", text: I18n.t("books.show.show")
  end

  test "書籍の情報を更新できる" do
    visit books_url
    click_on I18n.t("books_app.edit"), match: :first

    fill_in "Title", with: "うける本"
    fill_in "Memo", with: "めっちゃうける"
    fill_in "Author", with: "受間 栗太郎"

    click_on "commit"

    assert_text I18n.t("books_app.notice.success.update")
    click_on I18n.t("books_app.back")
  end

  test "書籍の情報を削除できる" do
    visit books_url
    page.accept_confirm do
      click_on I18n.t("books_app.destroy"), match: :first
    end

    assert_text I18n.t("books_app.notice.success.destroy")
  end
end
