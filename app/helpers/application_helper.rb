module ApplicationHelper
  def authenticate_admin
    !authenticate_user
    raise Error("not done doing this...")
    #if !current_user.
      flash[:error] = "You are not authorized to do that"
      redirect_to current_user
    
  end
end
