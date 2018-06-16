class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :color
      t.integer :rank, default: 500

      t.timestamps null: false
    end
  end
end
