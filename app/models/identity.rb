require 'role_model'

class Identity < ActiveRecord::Base
    belongs_to :user
    
    after_save :send_password
    
    def send_password
        if self.provider == 'local'
            # send an email with self.user.password 
        end   
    end
end
