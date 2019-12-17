class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|

      t.references :group
      
      t.string :title
      t.text :contents

      t.timestamps
    end
  end
end
