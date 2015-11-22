class AddUser1ChoiceToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :user1_choice, :integer
  end
end
