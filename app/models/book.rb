# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :post_user, class_name: "User", foreign_key: :user_id
  mount_uploader :picture, PictureUploader
end
