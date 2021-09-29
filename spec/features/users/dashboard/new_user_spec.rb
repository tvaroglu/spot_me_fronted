require 'rails_helper'

describe 'new user dashboard', type: :feature do
  context 'when I log in as an authenticated user' do
    # See spec/shared_contexts/features/current_user_shared_context.rb for context
    include_context 'logged in as authenticated user'

    let(:empty_arr) { [] }

    before do
      allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return(empty_arr)
      allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return(empty_arr)
      allow(EventFacade).to receive(:get_upcoming_events).with(user.id).and_return(empty_arr)
      allow(GymFacade).to receive(:get_gyms_near_user).with(user.zip_code).and_return(empty_arr)
    end

    context 'when I visit my user dashboard' do
      before { visit dashboard_index_path }

      context "when I don't have any friends" do
        it 'displays "You currently have no friends."', :vcr do
          within '#friends' do
            expect(page).to have_content('You currently have no friends.')
          end
        end
      end

      context "when I don't have any gyms" do
        it 'displays "You currently are not a member of any gyms."', :vcr do
          within '#gyms' do
            expect(page).to have_content('You currently are not a member of any gyms.')
          end
        end
      end

      context "when I don't have any workouts" do
        it 'displays "You currently have no upcoming workouts."', :vcr do
          within '#upcoming-workouts' do
            expect(page).to have_content('You currently have no upcoming workouts.')
          end
        end
      end
    end
  end
end
