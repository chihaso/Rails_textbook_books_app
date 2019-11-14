# frozen_string_literal: true

class RemoveDestinationTypeToComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :destination_type
  end
end
