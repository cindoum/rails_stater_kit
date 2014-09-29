class AdminController < ApplicationController
    before_action :authenticate_user!
    authorize_resource :class => false
    respond_to :json
    
    def index 
        render :status => 200, :json => FormatResponse.doFormat(true, nil, User.all)
    end
end
