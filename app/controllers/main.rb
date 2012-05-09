Forge.controllers :main, :provides => [:html] do         
  
  get :index, :map => '/' do                   
    render 'main/index'
  end 
  
  get :learn, :map => '/learn-more' do                   
    render 'main/learn'
  end
  
  get :faq, :map => '/faq' do                   
    render 'main/faq'
  end  
  
  get :support, :map => '/support' do                   
    render 'main/support'
  end
  
  get :about, :map => '/about' do                   
    render 'main/about'
  end
  
  get :privacy, :map => '/privacy-policy' do                   
    render 'main/privacy'
  end
  
  get :tos, :map => '/terms-of-service' do                   
    render 'main/tos'
  end  
end      