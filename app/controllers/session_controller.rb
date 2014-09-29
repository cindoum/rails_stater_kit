class SessionController < Devise::SessionsController
    protect_from_forgery with: :null_session
    respond_to :json
    
    def create
        resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        render :status => 200, :json => FormatResponse.doFormat(true, "Logged in", current_user)
    end
    
    def destroy
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        sign_out
        render :status => 200, :json => FormatResponse.doFormat(true, "Logged out", nil)
    end
    
    def failure errs
        warden.custom_failure!
        render :status => 401, :json => FormatResponse.doFormat(false, "Login failed", errs)
    end
    
    def show_current_user
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        render :status => 200, :json => FormatResponse.doFormat(true, nil, current_user)
    end
end
