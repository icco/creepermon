CreeperMon::App.controllers  do
  layout :main

  get :home do
    if !authenticated?
      redirect url(:index)
    else
      @title = "Home"
      render :home
    end
  end

  get :index do
    if authenticated?
      redirect url(:home)
    else
      render :index
    end
  end

  get :login do
    render :login
  end

  # Github callback
  get "/auth/github/callback" do
    auth = request.env["omniauth.auth"]
    logger.push(" Github: #{auth.inspect}", :devel)

    session[:user] = auth["info"]["nickname"]
    session[:token] = auth["credentials"]["token"]

    redirect "/"
  end

  # Developer callback
  post "/auth/developer/callback" do
    auth = request.env["omniauth.auth"]
    logger.push(" Devel: #{auth.inspect}", :devel)

    if !auth["info"]["nickname"].empty?
      session[:user] = auth["info"]["nickname"]
      session[:token] = nil

      redirect "/"
    else
      redirect :logout
    end
  end

  get "/auth/failure" do
    params[:message]
  end

  get :logout do
    if session
      session[:user] = nil
      session[:token] = nil
    end

    redirect '/'
  end
end
