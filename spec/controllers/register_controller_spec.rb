require 'spec_helper'
require 'faker'
require 'pp'

describe RegistrationController, :type => :controller do
    describe "GET #index" do
        context "Authorization test (CANCAN)" do
            it "allow not logged in user" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                user = FactoryGirl.attributes_for(:user, password: '12345', user_name: 'test', admin: true)
                
                post :create, :user => user
    
                expect(response).to be_success
                expect(response.status).to eq(200)
            end
        end
        context "JSON structure" do
           it "return json object well structured on success" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                user = FactoryGirl.attributes_for(:user, password: '12345', user_name: 'test', admin: true)
                
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
                user = FactoryGirl.attributes_for(:user, password: '12345', user_name: nil, :email => nil, admin: true)
                
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
           it "Create a user when admin == false" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                user = FactoryGirl.attributes_for(:user, password: '12345', user_name: 'test', admin: false)
                
                post :create, :user => user
    
                expect(response).to be_success
                expect(User.last.roles_mask).to eq(2)
           end
           it "Create an admin when admin == true" do
                @request.env["devise.mapping"] = Devise.mappings[:user]
                user = FactoryGirl.attributes_for(:user, password: '12345', user_name: 'test', admin: true)
                
                post :create, :user => user
    
                expect(response).to be_success
                expect(User.last.roles_mask).to eq(1)
           end
        end
    end
end