class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :url
      t.string :type
      t.string :topic
      t.decimal :t

      t.timestamps null: false
    end
  end
end
