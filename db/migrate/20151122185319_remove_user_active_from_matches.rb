class RemoveUserActiveFromMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :user1_active, :boolean
    remove_column :matches, :user2_active, :boolean
  end
end
