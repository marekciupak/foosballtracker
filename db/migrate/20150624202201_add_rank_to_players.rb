class AddRankToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :rank, :decimal, default: 1000
    add_index :players, :rank
  end
end
