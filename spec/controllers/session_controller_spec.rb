require 'spec_helper'
require 'faker'
require 'pp'

describe SessionController, :type => :controller do
    describe "POST #index" do
        context "Authorization test (CANCAN)" do
            it "allow not logged in user" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                
                user = FactoryGirl.create(:user);
                user = FactoryGirl.attributes_for(:user, password: user.password, email: user.email)
                
                post :create, :user => user
    
                expect(response).to be_success
                expect(response.status).to eq(200)
            end
        end
        context "JSON structure" do
           it "return json object well structured on success" do
               @request.env["devise.mapping"] = Devise.mappings[:user]
                
                user = FactoryGirl.create(:user);
                user = FactoryGirl.attributes_for(:user, password: user.password, email: user.email)
                
                post :create, :user => user
                
                body = JSON.parse(response.body)
                
                expect(response).to be_success
                
                expect(body.include? "success").to be true
                expect(body["success"]).to be true
                
                expect(body.include? "info").to be true
                expect(body.include? "data").to be true
           end
           
           it "return json object well structured on failure" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                
                user = FactoryGirl.create(:user);
                user = FactoryGirl.attributes_for(:user, password: '11111a', email: user.email)
                
                post :create, :user => user
                
                body = JSON.parse(response.body)
                
                expect(response).not_to be_success
                
                expect(body.include? "success").to be true
                expect(body["success"]).to be false
                
                expect(body.include? "info").to be true
                expect(body.include? "data").to be true
           end
        end
        context "Data test" do
           it "return the user created" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                
                user = FactoryGirl.create(:user);
                user = FactoryGirl.attributes_for(:user, password: user.password, email: user.email)
                
                post :create, :user => user
    
                body = JSON.parse(response.body)
                
                expect(body["data"]["email"]).to eq(User.last.email)
           end
        end
    end
    describe "POST #destroy" do
        context "Authorization test (CANCAN)" do
            it "fail if user is not loggued in" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                
                post :destroy
    
                expect(response).not_to be_success
                expect(response.status).to eq(401)
            end
            it "allow loggued in user" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                sign_in FactoryGirl.create(:user)
                
                post :destroy
    
                expect(response).to be_success
                expect(response.status).to eq(200)
            end
        end
        context "JSON structure" do
           it "return json object well structured on success" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                sign_in FactoryGirl.create(:user)
                
                post :destroy
                
                body = JSON.parse(response.body)
                
                expect(response).to be_success
                
                expect(body.include? "success").to be true
                expect(body["success"]).to be true
                
                expect(body.include? "info").to be true
                expect(body.include? "data").to be true
           end
           
           it "return json object well structured on failure" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                
                post :destroy
                
                body = JSON.parse(response.body)
                
                expect(response).not_to be_success
                
                expect(body.include? "success").to be true
                expect(body["success"]).to be false
                
                expect(body.include? "info").to be true
                expect(body.include? "data").to be true
           end
        end
    end
    describe "POST #show_current_user" do
        context "Authorization test (CANCAN)" do
            it "refuse not logged in user" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
            
                get :show_current_user
    
                expect(response).not_to be_success
                expect(response.status).to eq(401)
            end
            it "allow logged in user or admin" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                sign_in FactoryGirl.create(:user)
                
                get :show_current_user
    
                expect(response).to be_success
                expect(response.status).to eq(200)
            end
        end
        context "JSON structure" do
           it "return json object well structured on success" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                sign_in FactoryGirl.create(:user)
                
                get :show_current_user
                
                body = JSON.parse(response.body)
                
                expect(response).to be_success
                
                expect(body.include? "success").to be true
                expect(body["success"]).to be true
                
                expect(body.include? "info").to be true
                expect(body.include? "data").to be true
           end
           
           it "return json object well structured on failure" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
            
                get :show_current_user
                
                body = JSON.parse(response.body)
                expect(response).not_to be_success
                
                expect(body.include? "success").to be true
                expect(body["success"]).to be false
                
                expect(body.include? "info").to be true
                expect(body.include? "data").to be true
           end
        end
        context "Data test" do
           it "return the current user" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                sign_in FactoryGirl.create(:user)
                
                get :show_current_user
    
                body = JSON.parse(response.body)
                
                expect(body["data"]["email"]).to eq(User.last.email)
           end
        end
    end
end