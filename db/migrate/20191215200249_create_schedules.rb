class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|

      t.references :user
      t.integer :week, default: 0

      t.timestamps
    end
  end
end
