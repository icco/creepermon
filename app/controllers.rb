Creeper.controllers  do

  get :index do
    if session[:user].nil?
      redirect '/auth/github'
    else
      client = Octokit::Client.new({:auto_traversal => true})
      p client.repos
    end
  end

  # Github callback
  get '/auth/github/callback' do
    auth = request.env['omniauth.auth']
    auth = auth.info
    logger.push(" Github: #{auth.inspect}", :devel)

    session[:user] = auth['nickname']

    redirect '/'
  end
end
