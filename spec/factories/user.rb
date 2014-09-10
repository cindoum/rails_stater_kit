require 'faker'
require 'role_model'

FactoryGirl.define do
   factory :user do |p|
      p.user_name { Faker::Internet.user_name }
      p.password { Faker::Internet.password(8) }
      p.email { Faker::Internet.free_email }
      p.roles [:user]
   end
   
   factory :admin, class: User do |p|
      p.user_name { Faker::Internet.user_name }
      p.password { Faker::Internet.password(8) }
      p.email { Faker::Internet.free_email }
      p.roles [:admin]
   end
end