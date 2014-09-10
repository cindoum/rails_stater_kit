class AdminController < ApplicationController
    before_action :authenticate_user!
    authorize_resource :class => false
    respond_to :json
    
    def index
        render :status => 200, :json => { :success => true, :info => "", :data => User.all }
end
end
