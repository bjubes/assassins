class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.exists?
      flash[:notice] = "Signed in!"
      sign_in_and_redirect user
    else
      #persist user info for flash
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_path
    end
  end
  alias_method :twitter, :all
end
