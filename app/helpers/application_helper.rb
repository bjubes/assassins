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

  def back_link(text= "Back", html_class= "", html_id= "")
    s = %(<a class="#{html_class}" id="#{html_id}" href="#" onclick="history.go(-1);return false;">) + "#{html_escape(text)}</a>"
    s.html_safe
  end

  def bool_to_yn(bool)
    !!bool ? "yes" : "no"
  end

  def javascript_include_view_js
    if FileTest.exists? "app/assets/javascripts/"+params[:controller]+"/"+params[:action]+".js.erb"
      return '<script src="/assets/'+params[:controller]+'/'+params[:action]+'.js.erb" type="text/javascript"></script>'
    end
  end
end
