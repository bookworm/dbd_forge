ForgeApiV1.controllers :artifact, :provides => [:json, :html] do
  # Auth Check
  before do    
    oauth_check() if Padrino.env == :production
  end    
        
  # Artifact
  before(:show, :incompatible, :integrated, :compatible, :dependencies) do 
    @artifact = Artifact.find_by_slug(params[:slug])   
    halt 404 unless @artifact 
  end    
  
  get :show, :map => "/artifacts/:slug", :priority => :low do    
    data         = {:data => @artifact}
    data.to_json
  end
  
  get :incompatible, :map => "/artifacts/:slug/incompatible" do  
    incompatible = @artifact.incompatibilities
    data         = {:data => {:artifacts => incompatible, :count => incompatible.count} }
    data.to_json
  end   
  
  get :integrated, :map => "/artifacts/:slug/integrated" do  
    integrated = @artifact.integrations
    data       = {:data => {:artifacts => integrated, :count => integrated.count} }
    
    data.to_json
  end 
  
  get :compatible, :map => "/artifacts/:slug/compatible" do  
    compatible = @artifact.compatibilities 
    data       = {:data => {:artifacts => compatible, :count => compatible.count} }
    data.to_json
  end   
  
  get :dependencies, :map => "/artifacts/:slug/dependencies" do  
    dependencies = @artifact.dependencies
    data         = {:data => {:artifacts => dependencies, :count => dependencies.count} }
    data.to_json
  end
end       