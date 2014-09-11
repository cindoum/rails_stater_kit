Airbrake.configure do |config|
  config.ignore_only = []
  config.development_environments = []
  config.api_key = AppConfig.errbit['api_key']
  config.host    = 'errbitrails.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
  config.user_attributes = [:id, :name, :email]
end