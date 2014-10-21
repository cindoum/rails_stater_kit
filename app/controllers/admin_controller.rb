class AdminController < ApplicationController
    before_action :authenticate_user!
    authorize_resource :class => false
    respond_to :json
    
    def index 
        render FormatResponse.success(true, nil, User.all)
    end
end
