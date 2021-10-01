require 'rails_helper'

describe GymMembershipService, :vcr, type: :service do
  describe 'class methods' do
    describe '.create_gym_membership and .delete_gym_membership' do
      it 'creates and deletes a gym_membership' do
        user_id = 1
        yelp_gym_id = 'c2jzsndq8brvn9fbckeec2'
        gym_name = 'Planet Fitness'
        request_params = {
          'user_id': user_id,
          'yelp_gym_id': yelp_gym_id,
          'gym_name': gym_name
        }

        actual = GymMembershipService.create_gym_membership(request_params)
        actual_parsed = JSON.parse(actual.env.response_body, symbolize_names:true)
        expect(actual.status).to eq(201)
        expect(actual_parsed[:data][:attributes][:user_id]).to eq(user_id)
        expect(actual_parsed[:data][:attributes][:yelp_gym_id]).to eq(yelp_gym_id)
        expect(actual_parsed[:data][:attributes][:gym_name]).to eq(gym_name)

        gym_membership_id = actual_parsed[:data][:id]
        path_params = {
          user_id: user_id,
          id: gym_membership_id
        }

        actual = GymMembershipService.delete_gym_membership(path_params)
        expect(actual.env.url.to_s).to eq("https://spotme-app-api.herokuapp.com/api/v1/users/#{user_id}/gym_memberships/#{gym_membership_id}")
        expect(actual.status).to eq(204)
      end
    end

    describe '.get_gym_memberships' do
      it "returns the user's gym memberships" do
        user_id = 1
        actual = GymMembershipService.get_gym_memberships(user_id)
        expect(actual).to be_a(Hash)
        expect(actual).to have_key(:data)
        expect(actual[:data]).to be_an(Array)
        expect(actual[:data]).to all(have_key(:id))
        expect(actual[:data]).to all(have_key(:type))
        expect(actual[:data]).to all(have_key(:attributes))

        actual[:data].each do |gym_membership|
          expect(gym_membership[:attributes][:user_id]).to eq(user_id)
        end
      end
    end
  end
end
