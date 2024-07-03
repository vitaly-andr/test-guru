class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.text :body, null: false
      t.boolean :correct, default: false
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
