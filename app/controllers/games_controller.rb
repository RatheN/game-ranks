class GamesController < ApplicationController

    get '/games' do 
        if logged_in?
            @user = current_user
            @posts = current_user.games
            
            erb :'games/index'
        else
            redirect '/signup'
        end
    end

end
