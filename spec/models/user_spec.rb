require 'spec_helper'

describe User do
    context "Valid factory" do
        it "has a valid user factory" do
            user = FactoryGirl.create(:user)
            expect(user).to be_valid
        end
        
        it "has a valid admin factory" do
            admin = FactoryGirl.create(:admin)
            expect(admin).to be_valid
        end 
    end
    
    context "Presence of" do
        it "is not valid without email" do
            user = FactoryGirl.build(:user, :email => nil)
            expect(user).not_to be_valid
        end
        
        it "is not valid without user_name" do
            user = FactoryGirl.build(:user, :user_name => nil)
            expect(user).not_to be_valid
        end
        
        it "is not valid without password" do
            user = FactoryGirl.build(:user, :password => nil)
            expect(user).not_to be_valid
        end
    end
    
    context "Uniqueness" do
       it "is not valid if email is already taken" do
          user = FactoryGirl.create(:user)
          copyedUser = FactoryGirl.build(:user, :email => user.email)
          
          expect(copyedUser).not_to be_valid
       end
       
       it "is not valid if user_name is already taken" do
          user = FactoryGirl.create(:user)
          copyedUser = FactoryGirl.build(:user, :user_name => user.user_name)
          
          expect(copyedUser).not_to be_valid
       end
    end
end
