class TraitsController < ApplicationController

  get '/traits' do
    @sorted_traits = Trait.all.sort_by {|t| t.name}
    erb :"traits/index"
  end

  get '/users/:slug/traits' do
    login_check
    @user = User.find(session[:user_id])
    traits = @user.characters.map {|c| c.traits}.flatten
    @sorted_traits = traits.sort_by {|t| t.name}
    erb :"traits/show"
  end


end
