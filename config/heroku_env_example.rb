# Stripe 
if Padrino.env == :development or Padrino.env == :test  
  ENV['STRIPE_KEY']     = 'xxx'
  ENV['STRIPE_PUB_KEY'] = 'xxxx'       
end

ENV['STRIPE_KEY']     = 'xxxx' if Padrino.env == :production
ENV['STRIPE_PUB_KEY'] = 'xxxx' if Padrino.env == :production  

ENV["AIRBRAKE_API_KEY"] = "xxx"