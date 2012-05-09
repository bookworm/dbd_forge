require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Artifacts Controller" do    
  setup do    
    @artifact = Artifact.first
  end
  context "ajax" do 
    setup do
      header 'Accept', 'application/json' 
    end     
    
    should "return artifacts" do 
      get '/artifacts', {}, :xhr => true  
      assert last_response.status == 200
      
      artifacts = JSON.parse(last_response.body)
      assert !artifacts[0]['name'].blank?
      assert artifacts.length > 1
    end  
    
    should "paginate artifacts" do 
      get '/artifacts/page/1', {}, :xhr => true  
      assert last_response.status == 200
      
      artifacts = JSON.parse(last_response.body)
      assert !artifacts[0]['name'].blank?
      assert artifacts.length > 1
    end
       
    should "return an artifact" do   
      get "/artifacts/#{@artifact.slug}", {}, :xhr => true    
      assert last_response.status == 200
      
      artifact = JSON.parse(last_response.body)
      assert !artifact['name'].blank?
    end
  end
  
  context "normal" do  
    setup do
      header 'Accept', 'text/html ' 
    end     
    
    should "return artifacts" do   
      get '/artifacts'
      assert last_response.status == 200
    end  
    
    should "paginate artifacts" do  
      get '/artifacts/page/1'
      assert last_response.status == 200
    end   
    
    should "return an artifact" do   
      get "/artifacts/#{@artifact.slug}"
      assert last_response.status == 200
    end
  end
end