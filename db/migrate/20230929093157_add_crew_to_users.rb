class AddCrewToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :crew, :string
  end
end
