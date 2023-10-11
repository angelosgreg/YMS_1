class DeleteTotalToBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :total
  end
end
