# frozen_string_literal: true

class AddIndexToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :post_user, foreign_key: { to_table: :users }, default: "0"
  end
end
