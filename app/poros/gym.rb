class Gym
  include Convertable
  attr_reader :yelp_gym_id,
              :name,
              :full_address,
              :address1,
              :address2,
              :address3,
              :city_state_zip,
              :phone

  def initialize(data)
    @yelp_gym_id    = data[:id]
    @name           = data[:attributes][:name]
    @full_address   = data[:attributes][:address]
    @address1       = data[:attributes][:address_details][:address1]
    @address2       = data[:attributes][:address_details][:address2]
    @address3       = data[:attributes][:address_details][:address3]
    @city_state_zip = format_city_state_zip(data)
    @phone          = data[:attributes][:phone]
  end
end
