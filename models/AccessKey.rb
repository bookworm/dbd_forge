class AccessKey
  include MongoMapper::Document            
  
  # Keys
  key :accound_id, ObjectId
  key :shared,     String
  key :secret,     String 
  
  before_save :generate, :if => :generate_required?  
  
  def generate(key=nil)   
    if key
      if key.to_sym == :shared           
        self[:shared] = rand(100**25).to_s(36).slice(0, 28) 
      elsif key.to_sym == :secret  
        self[:secret] = rand(100**25).to_s(36).slice(0, 28)    
      end  
    else    
      self[:shared] = rand(100**25).to_s(36).slice(0, 28) 
      self[:secret] = rand(100**25).to_s(36).slice(0, 28)      
    end   
  end   
  
  def generate_required?() 
    return true if self[:shared].blank?
    return false
  end
end