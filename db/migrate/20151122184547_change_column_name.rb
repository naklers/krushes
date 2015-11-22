class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :matches, :user1_id, :choice1_id
    rename_column :matches, :user2_id, :choice2_id
  end
end
