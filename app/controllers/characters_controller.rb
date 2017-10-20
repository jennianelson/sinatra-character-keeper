class CharactersController < ApplicationController

  get '/characters/new' do
    erb :'characters/new'
  end

  post '/characters' do

  end

  get '/characters' do
    erb :'characters/index'
  end

  get '/characters/:slug' do
    erb :'characters/show'
  end

end
