class TraitsController < ApplicationController

  get '/traits' do
    @sorted_traits = Trait.all.sort_by {|t| t.name}
    erb :"traits/index"
  end

  get '/users/:slug/traits' do #belongs in users or traits controller?
    login_check
    @user = User.find(session[:user_id])
    traits = @user.characters.map {|c| c.traits}.flatten
    @sorted_traits = traits.sort_by {|t| t.name}.uniq
    erb :"traits/show"
  end


end
