require 'role_model'

class User < ActiveRecord::Base
    include RoleModel
    
    has_many :identities, :class_name => 'Identity', :dependent => :destroy
    
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:linkedin, :twitter, :google_oauth2]

    roles_attribute :roles_mask
    
    roles :admin, :user
    
    validates :password, presence: true, on: :create
    validates :user_name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    
    def active_for_authentication?
        super && self.is_enable
    end

    #def as_json(options)
        # this example DOES NOT ignore the user's options
        #super({:include => 'identities'}.merge(options))
    #end

    def self.from_omniauth auth
        user = User.where(:email => auth.info.email).first
        if user.nil?
            user = User.create(
                :email => auth.info.email,
                :password => Devise.friendly_token[6, 16],
                :user_name => auth.info.nickname || auth.info.name,
                :first_name => auth.info.fUsirst_name,
                :last_name => auth.info.last_name,
                :roles => [:user])
                
            user.identities.create([ {:uid => auth.uid, :provider => auth.provider}, {:uid => nil, :provider => 'local'}])
        end
        
        return nil unless user.is_enable == true
            
        identity = user.identities.where(:provider => auth.provider).first
        
        if identity.nil?
           user.identities.create(:uid => auth.uid, :provider => auth.provider)
        else
            if identity.uid != auth.uid
               return nil
           end
        end
        
        return user
    end
    
    def self.create_local_user user_params, is_admin
        user = User.new(user_params)
        user.user_name = user.email
        user.roles = if is_admin == true then [:admin] else [:user] end
        user.identities.new(:uid => nil, :provider => 'local')
        
        user
    end
end
