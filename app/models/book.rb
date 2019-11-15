# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  has_many :comments, foreign_key: "book_id", dependent: :destroy
  mount_uploader :picture, PictureUploader
end
