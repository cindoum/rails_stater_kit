Airbrake.configure do |config|
  config.ignore_only = []
  config.development_environments = []
  config.api_key = 'dd26695851224c0adbdae34f5471093a'
  config.host    = 'errbitrails.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
  config.user_attributes = [:id, :name, :email]
end