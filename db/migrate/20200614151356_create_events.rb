class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.boolean :edit_others
      t.references :user
      
      t.timestamps
    end
  end
end
