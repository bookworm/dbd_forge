require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Main Controller" do 
  setup do
    header 'Accept', 'text/html'  
  end
        
  should "return index" do  
    get "/"       
    assert last_response.status == 200
  end    
  
  should "return learn more" do  
    get "/learn-more"       
    assert last_response.status == 200
  end
  
  should "return faq" do  
    get "/faq"       
    assert last_response.status == 200
  end    
  
  should "return support" do  
    get "/support"       
    assert last_response.status == 200
  end
  
  should "return about" do  
    get "/about"       
    assert last_response.status == 200
  end
  
  should "return privacy-policy" do  
    get "/privacy-policy"       
    assert last_response.status == 200
  end
  
  should "return terms-of-service" do  
    get "/terms-of-service"       
    assert last_response.status == 200
  end
end