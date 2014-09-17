class Users::OmniauthCallbackController < Devise::OmniauthCallbacksController
  def linkedin
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if !@user.nil?
        sign_in_and_redirect @user, :event => :authentication
    else
        session["devise.auth_data"] = request.env["omniauth.auth"]
        redirect_to '/'
    end
  end
  
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if !@user.nil?
        sign_in_and_redirect @user, :event => :authentication
    else
        session["devise.auth_data"] = request.env["omniauth.auth"]
        redirect_to '/'
    end
  end
  
  def google
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if !@user.nil?
        sign_in_and_redirect @user, :event => :authentication
    else
        session["devise.auth_data"] = request.env["omniauth.auth"]
        redirect_to '/'
    end
  end
end