# frozen_string_literal: true

class CreateUserHits < ActiveRecord::Migration[7.0]
  def change
    create_table :hits do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :endpoint, null: false
      t.datetime :created_at
    end

    add_index :users, :created_at
  end
end
