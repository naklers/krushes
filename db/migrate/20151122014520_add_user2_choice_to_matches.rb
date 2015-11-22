class AddUser2ChoiceToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :user2_choice, :integer
  end
end
