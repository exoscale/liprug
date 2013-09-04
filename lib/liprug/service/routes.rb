require 'sinatra'
require 'rdiscount'
require 'slim'
require 'liprug/model'
require 'liprug/service/helpers'

module Liprug
  class Service < Sinatra::Base
    
    get '/' do
      slim :overview, :locals => Liprug::Model.fetch
    end

    get '/admin' do
      protected!
      slim :admin, :locals => Liprug::Model.fetch
    end

    post '/api/services' do
      protected!
      Liprug::Model.add_status(params[:name],
                               {
                                 :class => params[:class],
                                 :message => params[:message]
                               })
      redirect "/admin"
    end

    delete '/api/services/:service' do
      protected!
      Liprug::Model.delete_service params[:service]
      redirect "/admin"
    end

    post '/api/events' do
      protected!
      Liprug::Model.add_event({
                                :class => params[:class],
                                :message => params[:message]
                              })
      redirect "/admin"
    end

    delete '/api/events/:event' do
      protected!
      Liprug::Model.delete_event params[:event].to_i

      redirect "/admin"
    end
  end
end
