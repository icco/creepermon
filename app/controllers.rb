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

    redirect url(:home)
  end

  get :home do
    if !authenticated?
      redirect url(:index)
    else
      @title = "Home"
      render :home
    end
  end

  get :logout do
    session.destroy
    redirect url(:index)
  end
end

CreeperMon::App.controllers :config do
  post :update do
    current_user.repo = params["location"]
    current_user.save

    redirect url(:home)
  end
end

CreeperMon::App.controllers :user do
  get :edit do
    if !authenticated?
      redirect url(:index)
    else
      @title = "Edit User"
      render :user_edit
    end
  end
end
