class CreateVideo < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :description
      t.boolean :visible, default: false
      t.integer :duration, default: 0

      t.timestamps
    end
  end
end
