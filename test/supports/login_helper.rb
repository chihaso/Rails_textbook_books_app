# frozen_string_literal: true

module LoginHelper
  def login_user(user_email:, password:)
    visit "/users/sign_in"
    within(".new_user") do
      fill_in("user[email]", with: user_email)
      fill_in("user[password]", with: password)
    end
    click_button "commit"
  end
end
