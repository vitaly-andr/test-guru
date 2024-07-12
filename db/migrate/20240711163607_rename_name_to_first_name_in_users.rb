class RenameNameToFirstNameInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :name, :first_name
  end
end
