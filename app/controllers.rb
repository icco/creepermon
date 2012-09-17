Creeper.controllers  do

  get :index do
    if session[:user].nil?
      redirect "/auth/github"
    else
      client = Octokit::Client.new({
        :auto_traversal => true,
        :login => session[:user],
        :oauth_token => session[:token],
      })

      client.repos.inspect
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
end
