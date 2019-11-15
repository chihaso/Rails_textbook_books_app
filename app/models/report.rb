# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, foreign_key: "report_id", dependent: :destroy
end
