Forge.controllers :sessions do      
  get :new, :map => '/login' do             
    render "sessions/new"
  end  
  
  post :create do
    if account = Account.authenticate(params[:email], params[:password])
      set_current_account(account)
      redirect_back_or_default(url(:main, :index))
    else
      params[:email], params[:password] = h(params[:email]), h(params[:password])
      flash[:warning] = "Login or password wrong."
      redirect url(:sessions, :new)
    end
  end

  delete :destroy, :map => '/logout' do
    set_current_account(nil)
    redirect_back_or_default(url(:sessions, :new))
  end   
  
  get :logout, :map => '/logout' do
    set_current_account(nil)
    redirect_back_or_default(url(:sessions, :new))
  end
end