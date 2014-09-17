require 'role_model'

class User < ActiveRecord::Base
    include RoleModel
    
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:linkedin, :twitter, :google]

    roles_attribute :roles_mask
    
    roles :admin, :user
    
    validates :password, presence: true
    validates :user_name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    
    def self.from_omniauth auth
       where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.email = auth.info.email
          user.password = Devise.friendly_token[6, 16]
          user.user_name = auth.info.nickname
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.roles = [:user]
       end
    end
end
