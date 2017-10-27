class CharactersController < ApplicationController

  get '/characters/new' do
    login_check
    erb :'characters/new'
  end

  post '/characters' do
    @character = Character.new(params[:character])
    @user = User.find(session[:user_id])
    if @user.characters.include?(params[:character][:name])
      flash[:message] = "You have already added this character. Consider editing instead."
      redirect '/characters/new'
    end
    if @character.valid?
      @character.user = @user
      @character.trait_ids = params[:trait_ids]
      if !params[:traits].empty?
        params[:traits].each do |trait|
          if trait != ""
            @character.traits << Trait.create(name: trait)
          end
        end
      end
      @character.save
    else
      flash[:message] = "All fields marked with an * are required to create a character."
    end
    redirect "/characters/#{@character.slug}"
  end

  get '/characters' do
    login_check
    @sorted_characters = Character.all.sort_by {|character| character.name}
    erb :'characters/index'
  end

  get '/characters/:slug' do
    login_check
    @user = User.find(session[:user_id])
    @character = Character.find_by_slug(params[:slug])
    erb :'characters/show'
  end

  get '/characters/:slug/edit' do
    login_check
    @character = Character.find_by_slug(params[:slug])
    if current_user == @character.user
      erb :'characters/edit'
    else
      flash[:message] = "You may not edit a character that you did not create."
      redirect "/users/#{current_user.slug}"
    end
  end

  patch '/characters/:slug' do
    @character = Character.find_by_slug(params[:slug])
    if @character.valid?
      @character.update(params[:character])
      @character.trait_ids = params[:trait_ids]
      if !params[:traits].empty?
        params[:traits].each do |trait|
          if trait != ""
            @character.traits << Trait.create(name: trait)
          end
        end
      end
      @character.save
    else
      flash[:message] = "All fields marked with an * are required to update a character."
    end
    redirect "/characters/#{@character.slug}"
  end

  delete '/characters/:slug' do
    login_check
    @character = Character.find_by_slug(params[:slug])
    if current_user == @character.user
      @character.destroy
      erb :'/characters/delete'
    else
      flash[:message] = "You may not delete a character you did not create."
      redirect "/users/#{current_user.slug}"
    end
  end


end
