class CharactersController < ApplicationController

  get '/characters/new' do
    login_check
    erb :'characters/new'
  end

  post '/characters' do
    @character = Character.new(params[:character])
    if params[:character][:name] == Character.find_by(name: params[:character][:name])
      flash[:message] = "You have already added this character. Consider editing instead."
      redirect "/characters/new"
    end
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
      flash[:message] = "All fields are required to create a character."
    end
  end

  get '/characters' do
    erb :'characters/index'
  end

  get '/characters/:slug' do
    login_check
    @character = Character.find_by_slug(params[:slug])
    erb :'characters/show'
  end


end
