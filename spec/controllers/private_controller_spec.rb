require 'spec_helper'
require 'faker'
require 'pp'

describe PrivateController, :type => :controller do
    describe "GET #index" do
        context "Authorization test (CANCAN)" do
            it "refuse not logged in user" do
                get :index, :format => :json
    
                pp response.body
                pp response.status
    
                expect(response).not_to be_success
                expect(response.status).to eq(401)
            end
            
            it "allow user logged as normal user" do
                sign_in FactoryGirl.create(:user)
                get :index, :format => :json
                
                expect(response).to be_success
                expect(response.status).to eq(200)
            end 
            
            it "allow user logged as admin" do
                sign_in FactoryGirl.create(:admin)
                get :index, :format => :json
                
                expect(response).to be_success
                expect(response.status).to eq(200)
            end 
        end
        context "JSON structure" do
           it "return json object well structured on success" do
                sign_in FactoryGirl.create(:user)
                get :index, :format => :json
                
                body = JSON.parse(response.body)
                
                expect(response).to be_success
                
                expect(body.include? "success").to be true
                expect(body["success"]).to be true
                
                expect(body.include? "info").to be true
                expect(body.include? "data").to be true
           end
           
           it "return json object well structured on failure" do
                get :index, :format => :json
                
                body = JSON.parse(response.body)
                
                expect(response).not_to be_success
                
                expect(body.include? "success").to be true
                 expect(body["success"]).to be false
                
                expect(body.include? "info").to be true
                expect(body.include? "data").to be true
           end
        end
        context "Data test" do
           it "return 2 roles type" do
                sign_in FactoryGirl.create(:user)
                get :index, :format => :json
                
                body = JSON.parse(response.body)
                
                expect(response).to be_success
                expect(body["data"].count).to eq(2)
           end
        end
    end
end