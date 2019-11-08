# frozen_string_literal: true

class ChangeColumnToBooks < ActiveRecord::Migration[6.0]
  def change
    change_column :books, :post_user_id, :integer
  end
end
