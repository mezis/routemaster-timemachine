class AddIndexesToEventsTable < ActiveRecord::Migration
  def change
    add_index :events, :url
    add_index :events, :type
    add_index :events, :topic
    add_index :events, :t

    add_index :events, [:url, :type, :topic, :t]
  end
end
