class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :winner, index: true, foreign_key: true
      t.references :loser, index: true, foreign_key: true
      t.date :date
      t.integer :loser_score

      t.timestamps null: false
    end
  end
end
