class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :title
      t.references :event_detail

      t.timestamps
    end
    add_index :tags, :title
  end
end
