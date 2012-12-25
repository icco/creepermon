Creeper.controllers  do

  get :index do
    if session[:user].nil? or session[:token].nil?
      redirect "/auth/github"
    else
      @repos = gh_client.repos
      render :index
    end
  end

  # Github callback
  get "/auth/github/callback" do
    auth = request.env["omniauth.auth"]
    logger.push(" Github: #{auth.inspect}", :devel)

    session[:user] = auth["info"]["nickname"]
    session[:token] = auth["credentials"]["token"]

    redirect "/"
  end

  get "/auth/failure" do
    params[:message]
  end

  get "/logout" do
    session = {}
    redirect '/'
  end
end
