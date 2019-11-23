# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    login_user(user_email: "user_1@mail", password: "111111")
  end

  test "ユーザー一覧ページを表示できる" do
    visit users_url
    assert_selector "h1", text: I18n.t("books_app.page_title.user_index")
  end

  test "個別のユーザー情報ページが表示できる" do
    visit user_path(id: User.first.id)
    assert_selector "h1", text: I18n.t("users.show.profile")
  end

  test "新規にユーザーを登録できる" do
    click_on I18n.t("layouts.application.sign_out")
    click_on I18n.t("layouts.application.sign_up")
    fill_in "Email", with: "new_user@mail"
    file_path = Rails.root.join("app/assets/images/test_image_1.jpg")
    attach_file "user_avatar", file_path
    fill_in "user_name", with: "new_user"
    fill_in "user_password", with: "new_user"
    fill_in "user_password_confirmation", with: "new_user"
    fill_in "user_postal_code", with: "nnn-nnnn"
    fill_in "user_street_address", with:  "新人県新人市字新人40-20-1"
    fill_in "user_self_introduction", with: "新人です"
    click_on I18n.t("devise.registrations.new.sign_up")
    assert_text I18n.t("devise.registrations.signed_up")
  end

  test "自分のアカウントを編集できる" do
    visit edit_user_registration_path(id: users(:user_1).id)
    fill_in "Email", with: "edit@mail"
    file_path = Rails.root.join("app/assets/images/test_image_2.jpg")
    attach_file "user_avatar", file_path    
    fill_in "user_name", with: "edit_user"
    fill_in "user_password", with: "edit_user"
    fill_in "user_password_confirmation", with: "edit_user"
    fill_in "user_current_password", with: "111111"
    fill_in "user_postal_code", with: "eee-eee"
    fill_in "user_street_address", with:  "編集県編集市字編集60-44-3"
    fill_in "user_self_introduction", with: "編集です"
    click_on I18n.t("devise.registrations.edit.update")
    assert_text I18n.t("devise.registrations.updated")
  end

  test "自分のアカウントを削除できる" do
    visit edit_user_registration_path(id: users(:user_1).id)
    page.accept_confirm do
      click_on I18n.t("devise.registrations.edit.cancel_my_account")
    end
  end
end
