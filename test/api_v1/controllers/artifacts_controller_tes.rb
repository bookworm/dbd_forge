require File.expand_path(File.dirname(__FILE__) + '/../../test_api_config.rb')
  
describe "Artifacts API Controller" do  
  setup do
    header 'Accept', 'application/json'
  end  
   
  should "return 10 artifacts" do  
    get '/artifacts/all', {}, :xhr => true         
    artifacts = JSON.parse(last_response.body)['data']['artifacts']     
    assert artifacts.length == 10
  end   
  
  should "return 5 artifacts" do  
    get '/artifacts/all/5', {}, :xhr => true     
    artifacts = JSON.parse(last_response.body)['data']['artifacts']    
    assert artifacts.length == 5
  end         
  
  should "return 5 artifacts and skip 5" do  
    get '/artifacts/all/5/skip/5', {}, :xhr => true     
    artifacts = JSON.parse(last_response.body)['data']['artifacts']    
    assert artifacts.length == 5
  end   
  
  should "return 5 artifacts via tag" do  
    get '/artifacts/tag/cats/5/skip/5', {}, :xhr => true     
    artifacts = JSON.parse(last_response.body)['data']['artifacts']    
    assert artifacts.length == 5
  end  
  
  should "return 5 artifacts via type" do  
    get '/artifacts/type/component/5/skip/5', {}, :xhr => true     
    artifacts = JSON.parse(last_response.body)['data']['artifacts']    
    assert artifacts.length == 5
  end
end