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

    get '/games/all' do 
        if logged_in?
            @games = Game.all
            erb :'games/index'
        else
            redirect '/signup'
        end
    end

    get '/games/new' do
        @users = User.all
        erb :'/games/new'
    end

end
