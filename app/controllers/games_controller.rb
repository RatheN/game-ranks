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

    get "/games/:id/edit" do 
        user_game = Game.find_by_id(params[:id]).user
         if user_game.id == current_user.id
            @game = Game.find_by_id(params[:id])
            erb :'games/edit'
        else 
            flash[:err] = "This is not your review."
            redirect "/games"
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
            flash[:err] = "This is not your review."
            erb :"/games/index"
        end
    end

end
