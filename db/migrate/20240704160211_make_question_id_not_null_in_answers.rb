class MakeQuestionIdNotNullInAnswers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :answers, :question_id, false
  end
end
