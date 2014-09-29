class RegistrationController < Devise::RegistrationsController
    respond_to :json
    
    def create
        user = User.create_local_user user_params, params[:user][:admin]
        
        if user.save
            sign_in(user)
            render :status => 200, :json => FormatResponse.doFormat(true, "Account created", user)
        else
            warden.custom_failure!
            render :status => 422, :json => FormatResponse.doFormat(false, "Account not created",  user.errors)
       end
    end
    
    private
        def user_params
            params.require(:user).permit(:email, :password, :user_name)
            #params.require(:user).permit!
        end
end
