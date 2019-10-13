class UsersController < ApplicationController

    get '/signup' do 
        erb :'users/new'
    end

    post '/signup' do 
        if params[:name] == "" || params[:password] == ""
          redirect to '/signup'
        else
          @user = User.create(:name => params[:name], :password => params[:password])
          session[:user_id] = @user.id
          redirect '/games'
        end
      end
end