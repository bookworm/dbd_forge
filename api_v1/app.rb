require 'roauth'
require "stripe"   
require "garry"
Stripe.api_key = ENV['STRIPE_KEY']
class ForgeApiV1 < Padrino::Application  
  use Airbrake::Rack     
  register Padrino::Rendering
  register Padrino::Helpers   
  register Padrino::Responders    
end