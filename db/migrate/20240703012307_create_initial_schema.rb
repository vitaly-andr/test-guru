class CreateInitialSchema < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :title, null: false

      t.timestamps
    end

    create_table :tests do |t|
      t.string :title, null: false
      t.integer :level, default: 0
      t.references :category, foreign_key: true

      t.timestamps
    end

    create_table :questions do |t|
      t.text :body, null: false
      t.references :test, foreign_key: true

      t.timestamps
    end

    create_table :answers do |t|
      t.text :body, null: false
      t.boolean :correct, default: false
      t.references :question, foreign_key: true

      t.timestamps
    end

    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
#
