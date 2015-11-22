class RemoveUser1ChoiceFromMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :user1_choice, :integer
  end
end
