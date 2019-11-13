# frozen_string_literal: true

DESTINATION = [ nil, :book, :report ]

class Comment < ApplicationRecord
  belongs_to :post_user, class_name: "User", foreign_key: :user_id
  belongs_to :book, optional: true
  belongs_to :report, optional: true
end
