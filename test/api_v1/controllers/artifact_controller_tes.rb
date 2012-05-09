require File.expand_path(File.dirname(__FILE__) + '/../../test_api_config.rb')
  
describe "Artifact API Controller" do  
  setup do
    header 'Accept', 'application/json'
  end      

  should "return an artifact" do  
    get '/artifacts/bob', {}, :xhr => true          
    assert last_response.status == 200    
    artifact = JSON.parse(last_response.body)['data']   
    assert artifact['name'].blank? == false
  end     
  
  should "return incompatibilities" do 
    get '/artifacts/bob/incompatible', {}, :xhr => true  
    incompatibilities = JSON.parse(last_response.body)['data']   
    assert incompatibilities.length > 0
  end     
  
  should "return compatibilities" do    
    get '/artifacts/bob/compatible', {}, :xhr => true  
   compatibilities = JSON.parse(last_response.body)['data']   
    assert compatibilities.length > 0
  end  
  
  should "return integrations" do  
    get '/artifacts/bob/integrated', {}, :xhr => true     
    integrations = JSON.parse(last_response.body)['data']   
    assert integrations.length > 0
  end         
  
  should "return dependencies" do 
    get '/artifacts/bob/dependencies', {}, :xhr => true 
    dependencies = JSON.parse(last_response.body)['data']   
    assert dependencies.length > 0  
  end
end