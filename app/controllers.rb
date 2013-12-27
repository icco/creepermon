CreeperMon::App.controllers  do

  get :index do
    render :index
  end

  get :login do
    redirect url(:sessions, :login)
  end

  post :login do
    redirect :home
  end

  post :signup do
    redirect :home
  end

  get :home do
    require 'ostruct'

    @title = "Home"
    sites = (0..10).to_a.map {|i| Site.new(rand(36**15).to_s(36), "https://example.com/blah.git") }
    @config = OpenStruct.new(:location => "", :sites => sites)
    render :home
  end
end

class Site < Struct.new(:name, :repo)
end
