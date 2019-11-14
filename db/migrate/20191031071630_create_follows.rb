# frozen_string_literal: true

class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references :follower_id, foreign_key: { to_table: :users }
      t.references :followee_id, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
