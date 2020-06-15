class CreateEventDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :event_details do |t|
      t.integer :game_id
      t.string :owner
      t.string :title
      t.text :text
      t.datetime :date
      t.boolean :latest
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
