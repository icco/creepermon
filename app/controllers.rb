Creeper::App.controllers  do
  layout :main

  get :index do

    if session[:user].nil?
      render :login
    else
      @repos = get_repos
      render :index
    end
  end

  get :login do
    provider = Padrino.env == :development ? "developer" : "github"
    redirect "/auth/#{provider}"
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

    session[:user] = auth["info"]["nickname"]
    session[:token] = nil

    redirect "/"
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
