# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :postal_code, :string
    add_column :users, :street_address, :string
    add_column :users, :self_introduction, :text
  end
end
