# frozen_string_literal: true

require "application_system_test_case"

class FollowsTest < ApplicationSystemTestCase
  setup do
    login_user(user_email: "user_1@mail", password: "111111")
  end

  test "フォロワー一覧ページを表示できる" do
    visit followers_path(id: users(:user_1).id)
    assert_text I18n.t "books_app.page_title.followers"
  end

  test "フォロー一覧ページを表示できる" do
    visit following_index_path(id: users(:user_1).id)
    assert_text I18n.t "books_app.page_title.following"
  end

  test "未フォローのユーザーをフォローできる" do
    visit users_path
    within("#follow_form_#{users(:user_3).id}") do
      click_on(I18n.t("follows.follow.follow"))
      sleep 5
    end
    visit following_index_path(id: users(:user_1).id)
    assert_text "User_3"
  end

  test "フォローしているユーザーをフォロー解除できる" do
    visit users_path
    within("#follow_form_#{users(:user_2).id}") do
      click_on(I18n.t("follows.unfollow.unfollow"))
      sleep 5
    end
    visit following_index_path(id: users(:user_2).id)
    assert_text "User_2", count: 0
  end

  test "フォローしているユーザーが投稿した本の一覧ページを表示できる" do
    visit user_path(users(:user_2).id)
    click_on(I18n.t("users.show.user_posts"))
    assert_text I18n.t("books_app.page_title.user_posts", username: "User_2")
  end
end
