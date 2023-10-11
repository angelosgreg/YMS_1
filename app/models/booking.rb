class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :yacht
  has_one :income, dependent: :destroy

  def start_time
    self.check_in
  end

  def end_time
    self.check_out
  end
end
