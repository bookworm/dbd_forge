class Account       
  include MongoMapper::Document
  include Garry::Account   
  
  before_save :generate_access_key   
  
  def access_keys(query={})   
    AccessKey.all({:account_id => self.id}.merge!(query))
  end
  
  def access_key(query={}) 
    AccessKey.first({:account_id => self.id}.merge!(query))
  end           
  
  def generate_access_key()  
    unless self.access_key   
      key = AccessKey.new(:account_id => self.id) 
      key.save
    end
  end
end