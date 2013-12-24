CreeperMon::App.controllers  do
  layout :main

  get :index do
    render :index
  end

  get :login do
    render :login
  end
end
