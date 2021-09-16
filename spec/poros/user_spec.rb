require 'rails_helper'

RSpec.describe 'user poro' do
  it 'can initialize for user params' do
    user_params = ({id: 1,
                    email: '123@test.com',
                    name: 'Joe Shmoe',
                    google_id: 789,
                    google_image_url: 'pretty face',
                    zip_code: '80227',
                    summary: "Muy guesta gimnasios",
                    goal: 'gain weight',
                    availability_morning: true,
                    availability_afternoon: true,
                    availability_evening: false
                    })
    
    user = User.new(user_params)

    expect(user).to be_an_instance_of(User)
    expect(user.id).to eq(1)
    expect(user.email).to eq('123@test.com')
    expect(user.name).to eq('Joe Shmoe')
    expect(user.google_id).to eq(789)
    expect(user.google_image_url).to eq('pretty face')
    expect(user.zip_code).to eq('80227')
    expect(user.summary).to eq('Muy guesta gimnasios')
    expect(user.goal).to eq('gain weight')
    expect(user.availability_morning).to eq(true)
    expect(user.availability_afternoon).to eq(true)
    expect(user.availability_evening).to eq(false)
  end
end