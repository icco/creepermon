CreeperMon::App.controllers  do
  layout :main

  get :index do
    render :index
  end

  get :login do
    @title = "Login!"
    render :login
  end

  post :login do
    redirect :home
  end

  post :signup do
    redirect :home
  end

  get :home do
    @title = "Home"
    render :home
  end
end
