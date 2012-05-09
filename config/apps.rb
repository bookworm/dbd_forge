Padrino.configure_apps do
  enable :sessions
  set :session_secret, '2f354ea8dcb14274c104a3e7f363266f787620b4625380297e721c1c29d7afef'
end

# Mounts
Padrino.mount("Forge").to('/')            
Padrino.mount("api_v1", :app_class => "ForgeApiV1").to('/api/v1')
