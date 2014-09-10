Airbrake.configure do |config|
  config.ignore_only = []
  config.development_environments = []
  config.api_key = ENV["ERRBIT_API_KEY"]
  config.host    = 'errbitrails.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
  config.user_attributes = [:id, :name, :email]
end