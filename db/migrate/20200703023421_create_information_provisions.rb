class CreateInformationProvisions < ActiveRecord::Migration[6.0]
  def change
    create_table :information_provisions do |t|
      t.references :game
      t.string :owner
      t.string :title
      t.text :text
      t.datetime :date
      t.string :name
      t.string :contact

      t.timestamps
    end
  end
end
