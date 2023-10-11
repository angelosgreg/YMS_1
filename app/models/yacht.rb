class Yacht < ApplicationRecord
  geocoded_by :location
  after_validation :geocode_if_location_changed_and_not_offshore
  belongs_to :user
  validates :name, presence: true

  private

  def geocode_if_location_changed_and_not_offshore
    if will_save_change_to_location? && location != 'Offshore'
      geocode
    end
  end
end
