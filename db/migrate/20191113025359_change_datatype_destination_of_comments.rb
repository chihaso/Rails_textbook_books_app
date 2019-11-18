# frozen_string_literal: true

class ChangeDatatypeDestinationOfComments < ActiveRecord::Migration[6.0]
  def change
    change_column :comments, :destination, :integer, default: "0"
  end
end
