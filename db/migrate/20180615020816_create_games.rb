class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :winner, null: false
      t.integer :loser,  null: false
      t.date :played
      t.integer :wrank, default: 500
      t.integer :lrank, default: 500

      t.timestamps null: false
    end
  end
end
