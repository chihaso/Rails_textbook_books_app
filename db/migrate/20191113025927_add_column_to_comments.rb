# frozen_string_literal: true

class AddColumnToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :book, foreign_key: true
    add_reference :comments, :report, foreign_key: true
    rename_column :comments, :destination, :destination_type
  end
end
