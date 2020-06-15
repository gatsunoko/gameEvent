class CreateEventDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :event_details do |t|
      t.references :game
      t.string :owner
      t.string :title
      t.text :text
      t.datetime :date
      t.boolean :latest
      t.references :user
      t.references :event

      t.timestamps
    end
  end
end
