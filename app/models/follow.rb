# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower_id, class_name: "User"
  belongs_to :followee_id, class_name: "User"

  validates :follower_id, presence: true
  validates :followee_id, presence: true
end
