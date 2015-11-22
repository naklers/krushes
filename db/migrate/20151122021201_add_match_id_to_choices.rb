class AddMatchIdToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :match_id, :integer
  end
end
