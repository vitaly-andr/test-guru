class CreateUserTests < ActiveRecord::Migration[7.1]
  def change
    create_table :user_tests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.string :status, null: false, default: 'in_progress'

      t.timestamps
    end
  end
end
