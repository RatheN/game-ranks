class GamesController < ApplicationController

    get '/games' do 
        if logged_in?
            @user = current_user
            @games = current_user.games
            
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

    get '/games/:id' do
        @game = Game.find_by_id(params[:id])

        if @game 
            erb :'games/show'
        else
            redirect "/games"
        end
    end

    get "/games/:id/edit" do 
        user_game = Game.find_by_id(params[:id]).user
         if user_game.id == current_user.id
            @game = Game.find_by_id(params[:id])
            erb :'games/edit'
        else 
            redirect "/games"
        end
    end

    post "/games" do
        @g = current_user.games.build(params)
        
        if @g.save
            redirect "/games"
        else
            erb  :"/games/new"
        end
    end

    patch "/games/:id" do 
        user_game = Game.find_by_id(params[:id]).user
        if user_game.id == current_user.id
            @game = Game.find_by_id(params[:id])
            params.delete("_method")
            if @game.update(params)
                redirect "/games/#{@game.id}"
            else
                redirect "/games/#{@game.id}/edit"
            end
        else
            erb :"/games/index"
        end
    end

    delete '/games/:id' do
        user_game = Game.find_by_id(params[:id]).user
        if user_game.id == current_user.id
            Game.destroy(params[:id])
            redirect :'/games'
        else
            redirect :'/games'
        end
    end

end
