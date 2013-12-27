CreeperMon::App.controllers  do

  get :index do
    render :index
  end

  get :login do
    @title ="Login"
    render 'sessions/login'
  end

  get :signup do
    @title = "Signup"
    render 'sessions/new'
  end

  post :signup do
    u = User.new(
      name: params["username"],
      password: params["password"],
      password_confirmation: params["password_confirmation"],
    )
    p u.errors
    u.save
    p u.errors
    env['warden'].set_user(u)

    redirect :home
  end

  get :home do
    p current_user
    if !authenticated?
      redirect url(:index)
    else
      @title = "Home"
      sites = (0..10).to_a.map {|i| Site.new(rand(36**15).to_s(36), "https://example.com/blah.git") }
      @config = OpenStruct.new(:location => "", :sites => sites)
      render :home
    end
  end
end

class Site < Struct.new(:name, :repo)
end
