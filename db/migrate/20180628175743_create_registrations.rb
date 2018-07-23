class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.boolean :attended
      t.references :workshop, foreign_key: true
      t.references :attendee, foreign_key: true

      t.timestamps
    end
  end
end
