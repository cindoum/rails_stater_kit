# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all

admin = User.new({:first_name => "Dominic", :last_name => "Lapointe", :user_name => "Doum", :email => "dom.dlapointe@gmail.com", :password => "12345", :password_confirmation => "12345"})
admin.roles = [:admin]
admin.save

user = User.new({:first_name => "Anonymous", :last_name => "User", :user_name => "anon", :email => "anon@gmail.com", :password => "12345", :password_confirmation => "12345"})
user.roles = [:user]
user.save
