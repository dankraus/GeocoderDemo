class Venue < ActiveRecord::Base
  attr_accessible :name, :address1, :address2, :city, :state, :zip, :latitude, :longitude
  geocoded_by :full_street_address

  after_validation :geocode if :full_street_address_changed?

  validates(:name, presence: true, length: { maximum: 50 } )
  validates(:address1, presence: true, length: { maximum: 50 } )
  validates(:city, presence: true, length: { maximum: 50 } )
  validates(:zip, presence: true, length: { maximum: 10 } )

  belongs_to :user

  def full_street_address
    "#{address1} #{address2} #{city}, #{state} #{zip}"
  end

  def full_street_address_was
    "#{address1_was} #{address2_was} #{city_was}, #{state_was} #{zip_was}"
  end

  def full_street_address_changed?
    full_street_address != full_street_address_was
  end

end