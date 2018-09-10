class FiguresController < ApplicationController

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    figure = Figure.new(params[:figure])
    if !params[:title][:name].empty?
      figure.titles << Title.create(:name => params[:title][:name])
    end
    if !params[:landmark][:name].empty?
      figure.landmarks << Landmark.create(:name => params[:landmark][:name])
    end
    figure.save

    redirect '/figures'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/:id' do
    begin
      @figure = Figure.find(params[:id])
      @titles = @figure.titles
      @landmarks = @figure.landmarks
    rescue ActiveRecord::RecordNotFound => e
      "<h1>No figure id #{params[:id]}</h1>"
    else
      erb :'figures/show'
    end
  end

  patch '/figures/:id' do
    begin
      figure = Figure.find(params[:id].to_i)
    rescue ActiveRecord::RecordNotFound => e
      "<h1>No figure id #{params[:id]}</h1>"
    else
      figure.update(params[:figure])
      if !params[:title][:name].empty?
        figure.titles << Title.create(:name => params[:title][:name])
      end
      if !params[:landmark][:name].empty?
        figure.landmarks << Landmark.create(:name => params[:landmark][:name])
      end
      figure.save

      redirect "/figures/#{params[:id]}"
    end
  end

  get '/figures/:id/edit' do
    begin
      @figure = Figure.find(params[:id])
      @landmarks = Landmark.all
      @titles = Title.all
      @figure_titles = @figure.titles
      @figure_landmarks = @figure.landmarks
    rescue ActiveRecord::RecordNotFound => e
      "<h1>No figure id #{params[:id]}</h1>"
    else
      erb :'figures/edit'
    end
  end
end
