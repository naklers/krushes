class ChangeUsersPhoto < ActiveRecord::Migration
  def change
    change_column_default("users", "photo", nil)
  end
end
