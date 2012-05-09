require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
  
describe "Account Model" do        
  setup do  
    @account = Account.first()
  end        
  
  should "create a new account" do       
    account = Account.new(:email => Faker::Internet.email, :username => Faker::Internet.user_name, :name => Faker::Name.name, :password => 'samy', 
      :password_confirmation => 'samy')
    account.save
    assert account.errors.size == 0
    assert account.access_key.is_a?(AccessKey) == true
  end 
  
  should "return an accounts key" do  
    assert_instance_of AccessKey, @account.access_key
  end
end