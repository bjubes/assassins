module ApplicationHelper
  def authenticate_admin
    !authenticate_user
    raise Error("not done doing this...")
    #if !current_user.
      flash[:error] = "You are not authorized to do that"
      redirect_to current_user

  end

  def boostrap_color_from_status(status)
    return "success" if status == "alive"
    return "warning" if status == "endangered"
    return "danger" if status == "dead"
  end

  def back_link(text="Back")
    s = %(<a href="#" onclick="history.go(-1);return false;">) + "#{html_escape(text)}</a>"
    s.html_safe
  end
end
