require 'rails_helper'

RSpec.describe 'gyms show page' do
  before(:each) do
    visit gym_path('BJBXzKYxQAXZKb5W6HrRnA')
  end

  it 'displays the gym and its information', :vcr do
    within '#gym_attributes' do
      expect(page).to have_content("Rishi's Community Yoga")
      expect(page).to have_content('2750 S Wadsworth Blvd, Bldg D, Ste 202, Denver, CO 80227')
      expect(page).to have_content('(303) 601-0789')

      expect(page).to have_css('h1', count: 1) # gym name
      expect(page).to have_css('p', count: 2) # gym address and phone
    end
  end

  it 'has a button to add the gym membership', :vcr do
    expect(page).to have_button('Add Gym')
  end

  it 'adds the gym membership when you click that button', :vcr do
    visit dashboard_path(@user.id)

    expect(page).to_not have_content("Rishi's Community Yoga")

    visit gym_path('BJBXzKYxQAXZKb5W6HrRnA')

    click_on 'Add Gym'

    expect(current_path).to eq(dashboard_path(@user.id))
    expect(page).to have_content("Rishi's Community Yoga")
  end


  it 'displays the number of active members', :vcr do
    expect(page).to have_content("Number of Active Members: 1")
  end
end