class MembersController < ApplicationController
    before_action :authenticate_user!
    authorize_resource :class => false
    respond_to :json

    def index
        predicate = params[:predicate] || 'email'
        reverse = params[:reverse] != nil ? params[:reverse] == 'true' ? 'DESC' : 'ASC' : 'ASC'
        offset = params[:page] || 0
        order = predicate + ' ' + reverse
        search = params[:searchValue]
        limit = params[:limit]
        
        if !search.blank?
            search = '%%' + search + '%%'
            users = User.all(:order => order, :limit => limit, :offset => offset, :conditions => ['email like ? or first_name like ? or last_name like ?', search, search, search])
            count = User.count(:conditions => ['email like ? or first_name like ? or last_name like ?', search, search, search])
        else
            users = User.all(:order => order, :limit => limit, :offset => offset)
            count = User.count
        end
        
        render FormatResponse.success(nil, users, { :count => count })
    end
    
    def read 
        if params[:id].casecmp("new") == 0
            render FormatResponse.success(nil, nil, { is_new: true})
        else
            puts User.find(params[:id])
            render FormatResponse.success(nil, User.find(params[:id]), { is_new: false})
        end
    end
    
    def update 
        user = User.find(params[:user][:id])

        user.update(update_params) 
        
        render FormatResponse.success(true, "Member updated", user.errors)
    end
    
    def create
        user = User.create_local_user update_params, params[:user][:admin]
        
        if user.save
            render FormatResponse.success(true, "Member created", user)
        else
            warden.custom_failure!
            render FormatResponse.error(422, "Member not created",  user.errors)
       end
    end
    
    def delete
        
    end
    
    private
        def update_params
            params.require(:user).permit(:email, :password, :user_name, :last_name, :first_name, :roles_mask, :is_enable)
        end
end
