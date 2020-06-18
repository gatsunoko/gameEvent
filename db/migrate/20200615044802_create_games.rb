class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title
      t.integer :order_num, null: false, default: 0

      t.timestamps
    end
  end
end
