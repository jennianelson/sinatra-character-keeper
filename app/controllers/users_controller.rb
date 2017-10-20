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
    else
      "Error" #make flash message
    end
    redirect '/characters'
  end

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do

  end

  get '/logout' do

  end

end
