class AddNotNullConstraintToAuthorIdInTests < ActiveRecord::Migration[7.1]
  def up
    Test.where(author_id: nil).update_all(author_id: User.first.id)

    change_column_null :tests, :author_id, false
  end

  def down
    change_column_null :tests, :author_id, true
  end
end
