class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      @user = User.find_by(session[:user_id])
      redirect "/users/#{@user.slug}"
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    end
      flash[:message] = "We could not find an account associated with this username.  Try again or create an account."
      redirect '/login'
  end

  get '/signup' do
    if logged_in?
      user = User.find(session[:user_id])
      redirect "/users/#{user.slug}"
    end
    erb :'/users/signup'
  end

  post '/signup' do
    if User.find_by(username: params[:user][:username])
      flash[:message] = "There is already an account associated with this username. If it's you, log in instead. Otherwise, pick a different username."
      redirect '/signup'
    end
    @user = User.new(params[:user])
    @user.password_confirmation = params[:confirm_password]
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "There was an error creating your account. Be sure that you complete all fields and that you confirm your password correctly."
      redirect '/signup'
    end
  end

  get '/logout' do
    login_check
    session.clear
    redirect '/'
  end

  get '/users/:slug' do
    login_check
    @user = User.find(session[:user_id])
    @sorted_characters = @user.characters.sort_by {|c| c.name}
    erb :'users/show'
  end

end
