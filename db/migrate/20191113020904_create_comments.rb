# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true, null: false, default: ""
      t.string :destination
      t.text :memo
      t.timestamps
    end
  end
end
