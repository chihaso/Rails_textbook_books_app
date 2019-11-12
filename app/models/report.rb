# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :post_user, class_name: "User", foreign_key: :user_id
end
