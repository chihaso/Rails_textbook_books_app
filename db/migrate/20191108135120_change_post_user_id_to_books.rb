# frozen_string_literal: true

class ChangePostUserIdToBooks < ActiveRecord::Migration[6.0]
  def change
    change_column_default :books, :post_user_id, nil
  end
end
