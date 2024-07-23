class AddIndexToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_index :questions, :body
  end
end
