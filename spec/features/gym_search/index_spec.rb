require 'rails_helper'

describe 'gyms near me page', :vcr, type: :feature do
  # See spec/shared_contexts/features/current_user_shared_context.rb for context
  include_context 'logged in as authenticated user'

  before do
    allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return([])
    allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return([])
    allow(EventFacade).to receive(:get_upcoming_events).with(user.id).and_return([])

    visit dashboard_index_path
    within('#find-gyms') { click_on 'Find Gyms Near Me' }
  end

  it 'can find gyms near me', :vcr do
    expect(page).to have_content("Gyms Near My Zip Code: #{user.zip_code}")

    within '#gyms' do
      within '#BJBXzKYxQAXZKb5W6HrRnA' do
        expect(page).to have_content("Rishi's Community Yoga")
        expect(page).to have_content('2750 S Wadsworth Blvd, Bldg D, Ste 202, Denver, CO 80227')
        expect(page).to have_content('(303) 601-0789')
      end
    end
  end

  it 'has a link to each individual gym', :vcr do
    within '#BJBXzKYxQAXZKb5W6HrRnA' do
      expect(page).to have_link("Rishi's Community Yoga")
      click_on "Rishi's Community Yoga"
    end

    expect(page).to have_current_path(gym_path('BJBXzKYxQAXZKb5W6HrRnA'), ignore_query: true)
  end
end
