ForgeApiV1.controllers :artifacts, :provides => [:json, :html] do        
  # Auth Check
  before do    
    oauth_check() if Padrino.env == :production     
    @options = {}
  end         
  
  before(:all) do  
    @options[:limit] = 10
  end
  
  # Options
  before do
    @options[:limit] = params[:limit]   if params[:limit]  
    @options[:skip]  = params[:offset]  if params[:offset] 
    @options[:type]  = params[:type]    if params[:type]   
    @options[:tags]  = params[:tag]     if params[:tag]    
  
    if params[:integrations]
      @options[:integrations] ||= {"$in" => params[:integrations].to_s.downcase.split(",").join(" ").split(" ").uniq } 
    end         
  
    if params[:filter]
      @options[:ext_name] = {"$nin" => params[:filter].to_s.downcase.split(",").join(" ").split(" ").uniq }
    end    
    
    if params[:only] 
      @options[:ext_name] ||= {}
      @options[:ext_name].merge!({"$in" => params[:only].to_s.downcase.split(",").join(" ").split(" ").uniq })
    end
  
    @options.delete_if {|key, value| value == nil }      
  end    
  
  # Artifacts
  before(:all, :by_limit, :by_tag, :by_type) do
    @artifacts = Artifact.all(@options)   
    @options.delete('limit')
    @options.delete('skip')
  end  
  
  get :all, :map => "/artifacts/all" do      
    data   = {:count => Artifact.count({}.merge!(@options)), :artifacts => @artifacts}
    result = {:data => data}
    result.to_json
  end   
  
  get :by_limit, :map => "/artifacts/all/:limit(/skip/:skip)" do   
    data   = {:count => Artifact.count({}.merge!(@options)), :artifacts => @artifacts}
    result = {:data => data}
    result.to_json
  end   
  
  get :by_tag, :map => "/artifacts/tag/:tag(/:limit/skip/:skip)" do       
    data   = {:count => Artifact.count({:tags => params[:tag] }.merge!(@options)), :artifacts => @artifacts}   
    result = {:data => data}
    result.to_json
  end    
  
  get :by_type, :map => "/artifacts/type/:type(/:limit/skip/:skip)" do   
    data   = {:count => Artifact.count({:type => params[:type] }.merge!(@options)), :artifacts => @artifacts}  
    result = {:data => data}
    result.to_json
  end
end