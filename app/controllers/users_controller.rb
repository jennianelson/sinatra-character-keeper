class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/characters'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/characters'
    end
      flash[:message] = "We could not find an account associated with this username.  Try again or create an account."
      redirect '/login'
  end

  get '/signup' do
    if logged_in?
      redirect '/characters'
    end
    erb :'/users/signup'
  end

  post '/signup' do
    if User.find_by(username: params[:user][:username])
      flash[:message] = "There is already an account associated with this username. Try logging in."
      redirect '/'
    end
    @user = User.new(params[:user])
    @user.password_confirmation = params[:confirm_password]
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect '/characters'
    else
      flash[:message] = "Your username and password do not match."
      redirect '/signup'
    end
  end

  get '/logout' do
    login_check
    session.clear
    redirect '/'
  end

end
