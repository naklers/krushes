class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|

      t.integer :user_id

      t.integer :target_id

      t.integer :rank

      t.boolean :matched

      t.boolean :disclose_if_no_match


      t.timestamps

    end

  end
end
