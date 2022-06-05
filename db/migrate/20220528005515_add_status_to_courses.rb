class AddStatusToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :state, :integer, default: 0
  end
end
