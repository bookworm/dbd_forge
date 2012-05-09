ForgeApiV1.controllers :artifact, :provides => [:json, :html] do
  # Auth Check
  before do    
    oauth_check() if Padrino.env == :production
  end    
        
  # Artifact
  before(:show, :incompatible, :integrated, :compatible, :dependencies) do 
    @artifact = Artifact.first(:ext_name => params[:name])   
    halt 404 unless @artifact 
  end    
  
  get :show, :map => "/artifacts/:name", :priority => :low do    
    data         = {:data => @artifact}
    data.to_json
  end
  
  get :incompatible, :map => "/artifacts/:name/incompatible" do  
    incompatible = @artifact.incompatibilities
    data         = {:data => {:artifacts => incompatible, :count => incompatible.count} }
    data.to_json
  end   
  
  get :integrated, :map => "/artifacts/:name/integrated" do  
    integrated = @artifact.integrations
    data       = {:data => {:artifacts => integrated, :count => integrated.count} }
    
    data.to_json
  end 
  
  get :compatible, :map => "/artifacts/:name/compatible" do  
    compatible = @artifact.compatibilities 
    data       = {:data => {:artifacts => compatible, :count => compatible.count} }
    data.to_json
  end   
  
  get :dependencies, :map => "/artifacts/:name/dependencies" do  
    dependencies = @artifact.dependencies
    data         = {:data => {:artifacts => dependencies, :count => dependencies.count} }
    data.to_json
  end
end       