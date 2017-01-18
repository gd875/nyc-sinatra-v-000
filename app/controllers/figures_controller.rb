require 'pry'

class FiguresController < ApplicationController

    get '/figures' do
        erb :'/figures/index'
    end

    get '/figures/new' do
        erb :'/figures/new'
    end

    post '/figures' do
    @figure = Figure.create(params[:figure])

    if !params["title"]["name"].empty?
        if !Title.find_by(name: params["title"]["name"]) #if title doesn't exist
          @figure.titles << Title.create(name: params["title"]["name"])
      else
        @figure.titles << Title.find_by(name: params["title"]["name"]) #set @figure.title to existing title
      end
    end

    if !params["landmark"]["name"].empty?
        if !Landmark.find_by(name: params["landmark"]["name"]) #if landmark doesn't exist
          @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
      else
        @figure.landmarks << Landmark.find_by(name: params["landmark"]["name"]) #set @figure.landmarks to existing landmark
      end
    end
   @figure.save
    # flash[:message] = "Successfully created song."
    redirect to "/figures/#{@figure.id}"
  end

    get '/figures/:id' do
        @figure = Figure.find_by(id: params[:id])
        erb :'/figures/show'
    end

    get '/figures/:id/edit' do
        @figure = Figure.find_by(id: params[:id])
        erb :'/figures/edit'
    end

    patch '/figures/:id' do
        @figure = Figure.find_by(id: params[:id])
        @figure.update(params[:figure])

        if !params["title"]["name"].empty?
                if !Title.find_by(name: params["title"]["name"]) #if title doesn't exist
                  @figure.titles << Title.create(name: params["title"]["name"])
              else
                @figure.titles << Title.find_by(name: params["title"]["name"]) #set @figure.title to existing title
              end
        end

        if !params["landmark"]["name"].empty?
            if !Landmark.find_by(name: params["landmark"]["name"]) #if landmark doesn't exist
              @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
          else
            @figure.landmarks << Landmark.find_by(name: params["landmark"]["name"]) #set @figure.landmarks to existing landmark
          end
        end
       @figure.save
        redirect to "/figures/#{@figure.id}"
    end

end
