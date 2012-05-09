Forge.controllers :artifacts, :provides => [:json, :html] do        
  before(:index) do 
    if params[:page]     
      @pagenum = params[:page].to_i
      halt 403, "Malformed Pagenum" if !@pagenum.is_a?(Numeric)  
    else  
      @pagenum = 0     
    end
  end   
  
  before(:index) do    
    options = {} 
    if request.xhr? or mime_type(:json) == request.preferred_type  
      @artifacts = Artifact.all(:skip => @pagenum * 5, :limit => 5)
    else   
      @pager = Paginator.new(Artifact.count, 5) do |offset, per_page|
        options[:skip] = offset 
        options[:limit] = per_page
        Artifact.all(options)  
      end
      @artifacts = @pager.page(@pagenum)
    end
  end     
  
  before(:show) do    
    @artifact = Artifact.find_by_slug(params[:slug])
  end
  
  get :index, :map => '/artifacts(/page/:page)' do   
    respond(@artifacts)
  end
  
  get :show, :map => '/artifacts/:slug' do       
    respond(@artifact)
  end  
end  