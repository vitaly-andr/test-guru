class AddIndexToAnswers < ActiveRecord::Migration[7.1]
  def change
    add_index :answers, :body
  end
end
