class AddLocationToYachts < ActiveRecord::Migration[7.0]
  def change
    add_column :yachts, :location, :string
  end
end
