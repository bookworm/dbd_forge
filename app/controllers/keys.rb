Forge.controllers :keys, :provides => [:json, :html] do    
  before(:regenerate) do  
    @key = current_account.access_key(:shared => params[:shared])  
    halt 403, "This is not your key?" unless @key
  end   
  
  get :regenerate, :map => '/keys/regenerate/:shared' do      
    @key.generate(params[:key])    
    @key.save
    respond(@key, back_or_default(url(:accounts, :show)))
  end
end