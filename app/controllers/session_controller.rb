class SessionController < Devise::SessionsController
    protect_from_forgery with: :null_session
    respond_to :json
    
    def create
        resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        render FormatResponse.success(true, "Logged in", current_user)
    end
    
    def destroy
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        sign_out
        render FormatResponse.success(true, "Logged out", nil)
    end
    
    def failure errs
        warden.custom_failure!
        render FormatResponse.error(401, "Login failed", errs, nil)
    end
    
    def show_current_user
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        render FormatResponse.success("Current User", current_user, nil)
    end
end
