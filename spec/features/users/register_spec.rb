require 'rails_helper'

RSpec.describe 'registration page' do
  describe 'happy path' do
    let(:headers) { {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent' => 'Faraday v1.7.1'
      # 'Authorization'=>ENV['bearer']
    } }

    let(:user_blob) { File.read('./spec/fixtures/user.json') }
    let(:get_user_request) { stub_request(:get, "#{BackEndService.base_url}/users/1")
      .with(headers: headers)
      .to_return(status: 200, body: user_blob, headers: {}) }

    let(:post_user_request) { stub_request(:post, "#{BackEndService.base_url}/users")
      .with(headers: headers, body: user_blob)
      .to_return(status: 204, headers: {}) }

    it 'is on the correct page' do
      visit registration_path

      expect(page).to have_field(:name)
      expect(page).to have_field(:email)
      expect(page).to have_field(:zip_code)
      expect(page).to have_field(:summary)
      expect(page).to have_field(:goal)

      expect(page).to have_content('Availability')
      expect(page).to have_field(:availability_morning)
      expect(page).to have_field(:availability_afternoon)
      expect(page).to have_field(:availability_evening)

      expect(page).to have_button('Register')
    end

    it 'can register a new user if all required attributes are provided' do
      visit registration_path

      # janky stub #1... this one prevents us from hitting Faraday.post (until we figure that method call out)
      allow(BackEndService).to receive(:send_request).and_return(204)
      # janky stub #2... have to double-JSON parse the fixture file for some reason..
      allow(BackEndService).to receive(:get_user)
        .and_return(JSON.parse(JSON.parse(user_blob), symbolize_names: true))

      fill_in :name, with: 'Foo Bar'
      fill_in :email, with: 'test@testing.com'
      fill_in :zip_code, with: '80227'
      fill_in :summary, with: 'Hello World'
      select 'Gain Weight', from: :goal
      page.check :availability_morning

      click_on 'Register'

      expect(current_path).to eq(dashboard_path(1))
    end
  end

  describe 'sad path' do
    xit "can't register a new user if all required attributes are provided" do
      # stuff
    end
  end
end
