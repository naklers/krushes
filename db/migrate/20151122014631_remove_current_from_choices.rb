class RemoveCurrentFromChoices < ActiveRecord::Migration
  def change
    remove_column :choices, :current, :boolean
  end
end
