class AddCurrentToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :current, :boolean, default: true
  end
end
