class AddIndexToMatches < ActiveRecord::Migration
  def change
  	add_index :matches, :date
  end
end
