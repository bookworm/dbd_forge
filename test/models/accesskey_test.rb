require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
  
describe "Access Key" do      
  setup do  
    @account = Account.first()
  end    
  
  should "create new access key" do  
    key = AccessKey.new(:account_id => @account.id)        
    key.save
    assert key.errors.size == 0
  end  
  
  should "regenerate access keys" do    
    key = AccessKey.first()
    prev_shared = key.shared
    prev_secret = key.secret
    key.generate()
    key.save
    
    assert prev_shared != key.shared     
    assert prev_secret != key.secret
  end        
end 