# frozen_string_literal: true

class AddColimnToReport < ActiveRecord::Migration[6.0]
  def change
    add_reference :reports, :user, foreign_key: true
  end
end
