class CreateYachts < ActiveRecord::Migration[7.0]
  def change
    create_table :yachts do |t|
      t.string :name
      t.integer :number_of_guests
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
