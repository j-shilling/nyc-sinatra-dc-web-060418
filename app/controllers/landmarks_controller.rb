class LandmarksController < ApplicationController

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  post '/landmarks' do
    Landmark.create(params[:landmark])
    redirect "/landmarks"
  end

  get '/landmarks/:id' do
    begin
      @landmark = Landmark.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      "<h1>No such landmark id #{params[:id]}</h1>"
    else
      erb :'landmarks/show'
    end
  end

  patch '/landmarks/:id' do
    begin
      @landmark = Landmark.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      "<h1>No such landmark id #{params[:id]}</h1>"
    else
      @landmark.update(params[:landmark])
      redirect "/landmarks/#{@landmark.id}"
    end
  end

  get '/landmarks/:id/edit' do
    begin
      @landmark = Landmark.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      "<h1>No such landmark id #{params[:id]}</h1>"
    else
      erb :'landmarks/edit'
    end
  end
end
