# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    login_user(user_email: "user_1@mail", password: "111111")
  end

  test "日報一覧ページを表示できる" do
    visit reports_url
    assert_selector "h1", text: I18n.t("reports.index.index")
  end

  test "新規に日報を登録できる" do
    visit reports_url
    click_on I18n.t("reports.index.new_report")

    fill_in "Title", with: "とても良い日報"
    fill_in "Memo", with: "わかりやすく濃い内容"

    click_on "commit"
    assert_text I18n.t("reports.create.success.create")
  end

  test "個別の日報ページを表示できる" do
    visit reports_url
    click_on I18n.t("reports.index.show"), match: :first
    assert_selector "h1", text: I18n.t("reports.show.show")
  end

  test "自分が書いた日報を更新できる" do
    visit reports_url
    click_on I18n.t("reports.index.edit"), match: :first

    fill_in "Title", with: "ながい日報"
    fill_in "Memo", with: "10万字"

    click_on "commit"

    assert_text I18n.t("reports.update.success.update")
    click_on I18n.t("reports.show.back")
  end

  test "自分が書いた日報を削除できる" do
    visit reports_url
    page.accept_confirm do
      click_on I18n.t("reports.index.destroy"), match: :first
    end

    assert_text I18n.t("reports.destroy.success.destroy")
  end

  test "自分が書いた日報にのみ編集ボタンが表示される" do
    visit reports_url
    num_of_edit_links = page.all(:link, I18n.t("reports.index.edit")).count
    assert_equal 3, num_of_edit_links
  end

  test "自分が書いた日報にのみ削除ボタンが表示される" do
    visit reports_url
    num_of_delete_links = page.all(:link, I18n.t("reports.index.destroy")).count
    assert_equal 3, num_of_delete_links
  end
end
