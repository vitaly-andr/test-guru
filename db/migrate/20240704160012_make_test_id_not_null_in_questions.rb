class MakeTestIdNotNullInQuestions < ActiveRecord::Migration[7.1]
  def change
    change_column_null :questions, :test_id, false
  end
end
