require 'padrino/sprockets'   
require "stripe"   
require "garry"
Stripe.api_key = ENV['STRIPE_KEY']
class Forge < Padrino::Application  
  use Airbrake::Rack     
  register Padrino::CSRF
  register Padrino::Rendering
  register Padrino::Helpers   
  register Padrino::Admin::AccessControl 
  register CompassInitializer

  enable :sessions 
  disable :prevent_request_forgery            
  
  set :stylesheets_folder, :css
  set :javascripts_folder, :js
  register Padrino::AssetHelpers
  register Padrino::Sprockets   
  register Padrino::Responders    
  
  ## 
  # Assets
  #
  
  assets do    
    digest false  
    handle_stylesheets false  
    assets_folder '/public'
    append_path 'assets/js'  
    append_path '../lib/assets/js'
    append_path '../vendor/assets/js'   
  end  
  
  access_control.roles_for :any do |role|       
    role.protect "/accounts"     
    role.protect "/keys"     
    role.allow   "/accounts/new"
    role.allow   "/accounts/create"    
  end

  access_control.roles_for :registered do |role|
    role.project_module :accounts, '/accounts'    
    role.project_module :keys, '/keys'
  end
end