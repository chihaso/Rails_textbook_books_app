# frozen_string_literal: true

class AddIndexToFollows < ActiveRecord::Migration[6.0]
  def change
    rename_column :follows, :follower_id_id, :follower_id
    rename_column :follows, :followee_id_id, :followee_id
    add_index :follows, [:follower_id, :followee_id], unique: true
  end
end
