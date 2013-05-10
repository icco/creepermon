Creeper::App.controllers  do
  layout :main

  get :index do
    if session[:user].nil?
      render :login
    else
      @user = User.factory session[:user]
      if @user.target
        render :index
      else
        render :new_user
      end
    end
  end

  get '/data/:site.json' do
    data = Ping.where("site like ?", "%#{params[:site]}%").order("created_at DESC").limit(604800)

    content_type :json
    data.to_a.to_json
  end

  post :index do
    if session[:user].nil?
      redirect :login
    else
      @user = User.factory session[:user]
      @user.target = params[:target]
      @user.save

      redirect '/'
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
