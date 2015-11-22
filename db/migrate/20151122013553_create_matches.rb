class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|

      t.integer :user1_id

      t.integer :user2_id

      t.boolean :user1_active

      t.boolean :user2_active


      t.timestamps

    end

  end
end
