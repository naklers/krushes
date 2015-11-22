class RemoveUser2ChoiceFromMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :user2_choice, :integer
  end
end
