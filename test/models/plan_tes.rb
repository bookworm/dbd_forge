require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
  
describe "Plan Model" do   
  should "create a new plan" do  
    plan = Plan.new(:amount => 2500, :interval => "month", :title => Faker::Lorem.words(3).join(" "), :name => Faker::Internet.user_name) 
    plan.save   
    
    assert plan.errors.size == 0
  end
  
  should "subscribe an account to a plan" do    
    plan = Plan.find_by_name('main')
    account = Account.first(:plan_id => nil)             
    account.subscribe(plan)
    
    account = Account.find_by_id(account.id)
    
    assert account.plan_id == plan.id
  end
end