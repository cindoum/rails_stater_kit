class Users::OmniauthCallbackController < Devise::OmniauthCallbacksController
  def linkedin
      pp '---------------------------------------------------**********************************************'
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
        resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        render :status => 200, :json => { :success => true, :info => "Logged in", :data => current_user }
    else
        user.roles = [:user]
        
        if user.save
            sign_in user
            render :status => 200, :json => { :success => true, :info => "Account created", :data => user }
        else
            warden.custom_failure!
            render :status => 422, :json => { :success => false, :info => "Account not created", :data => user.errors}
       end
    end
  end
end