class CreatePeriods < ActiveRecord::Migration[5.2]
  def change
    create_table :periods do |t|

      t.references :schedule

      t.integer :day
      
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end
