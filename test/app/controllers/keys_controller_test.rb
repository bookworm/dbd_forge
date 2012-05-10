require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Keys Controller" do 
  setup do      
    header 'Accept', 'application/json' 
    
    @account = Account.first(:first_name.ne => 'Bob')   
  
    post '/sessions/create', {:email => @account.email, :password => 'testpass'}  
    assert last_response.status == 302       
  
    follow_redirect!
  
    assert_equal "http://example.org/", last_request.url  
  end              
  
  should "regenerate key" do  
    key = @account.access_key()
    prev_shared = key.shared
    prev_secret = key.secret      
    
    get "/keys/regenerate/#{key.shared}", {}, :xhr => true     
    assert last_response.status == 200
       
    key = AccessKey.find_by_id(key.id) 
    
    assert prev_shared != key.shared     
    assert prev_secret != key.secret 
  end
end