class CharactersController < ApplicationController

  get '/characters/new' do
    login_check
    erb :'characters/new'
  end

  post '/characters' do
    @character = Character.new(params[:character])
    # if params[:character][:name] == Character.find_by(name: params[:character][:name])
    #   flash[:message] = "You have already added this character. Consider editing instead."
    #   redirect "/characters/new"
    # end       #THIS CHECKS THE ENTIRE CHARACTER DB, NOT JUST THE USER'S COLLECTION
    if @character.valid?
      @character.user_id = session[:user_id]
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
  end

  get '/characters' do
    login_check
    # binding.pry
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
    erb :'characters/edit'
  end

  patch '/characters/:slug' do
    @character = Character.find_by_slug(params[:slug])
    # binding.pry
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


end
