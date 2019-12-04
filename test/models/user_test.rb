# frozen_string_literal: true

require "test_helper"

class UsersTest < ActiveSupport::TestCase
  test "未フォローユーザーをフォローできる" do
    user1 = users(:user_1)
    user3 = users(:user_3)
    assert_not user1.following.include? user3
    user1.follow user3
    assert user1.following.include? user3
  end

  test "フォロー済みユーザーをフォロー解除できる" do
    user1 = users(:user_1)
    user2 = users(:user_2)
    assert user1.following.include? user2
    user1.unfollow user2
    assert_not user1.following.include? user2
  end

  test "フォロー済みユーザーを判別できる" do
    user1 = users(:user_1)
    user2 = users(:user_2)
    assert user1.following? user2
  end

  test "登録済みユーザーをOAuth認証情報から発見できる" do
    auth = OmniAuth::AuthHash.new(uid: "111", provider: "github")
    user1 = users(:user_1)
    auth_user = User.find_for_oauth(auth)
    assert auth_user == user1
  end

  test "未登録ユーザーのOAuth認証情報を受け取ったら新規にユーザーを登録する" do
    auth = OmniAuth::AuthHash.new(uid: "xxx", provider: "github")
    auth_user = User.find_for_oauth(auth)
    new_user = User.find_by email: "xxx-github@example.com"
    assert auth_user == new_user
  end
end
