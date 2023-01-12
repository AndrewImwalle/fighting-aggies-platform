# frozen_string_literal: true

class ChangeUsers < ActiveRecord::Migration[7.0]
  def change
    drop_table :users, if_exists: true
    drop_table :user, if_exists: true
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :role
      t.timestamps
    end
  end
end
