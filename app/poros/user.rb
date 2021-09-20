class User
  attr_reader :id,
              :email,
              :full_name,
              :google_id,
              :google_image_url,
              :zip_code,
              :summary,
              :goal,
              :availability_morning,
              :availability_afternoon,
              :availability_evening

  def initialize(user_params)
    @id = user_params[:id]
    @email = user_params[:email]
    @full_name = user_params[:full_name]
    @google_id = user_params[:google_id]
    @google_image_url = user_params[:google_image_url]
    @zip_code = user_params[:zip_code]
    @summary = user_params[:summary]
    @goal = user_params[:goal]
    @availability_morning = user_params[:availability_morning]
    @availability_afternoon = user_params[:availability_afternoon]
    @availability_evening = user_params[:availability_evening]
  end
end
