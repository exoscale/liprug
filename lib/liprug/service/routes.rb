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

    post '/api/past' do
      protected!
      Liprug::Model.add_past_event({
                                     :class => params[:class],
                                     :message => params[:message]
                                   })
      redirect "/admin"
    end

    post '/api/upcoming' do
      protected!
      Liprug::Model.add_upcoming_event({
                                         :class => params[:class],
                                         :message => params[:message]
                                       })
      redirect "/admin"
    end
    
    delete '/api/past/:event' do
      protected!
      Liprug::Model.delete_past_event params[:event].to_i

      redirect "/admin"
    end
    
    delete '/api/upcoming/:event' do
      protected!
      Liprug::Model.delete_upcoming_event params[:event].to_i

      redirect "/admin"
    end
  end
end
