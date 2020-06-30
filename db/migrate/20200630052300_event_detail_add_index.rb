class EventDetailAddIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :event_details, :title
    add_index :event_details, :owner
    add_index :event_details, :date
    add_index :event_details, :latest
  end
end
