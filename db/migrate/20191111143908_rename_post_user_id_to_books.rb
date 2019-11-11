# frozen_string_literal: true

class RenamePostUserIdToBooks < ActiveRecord::Migration[6.0]
  def change
    rename_column :books, :post_user_id, :user_id
  end
end
