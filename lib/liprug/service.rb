require 'sinatra'
module Liprug
  class Service < Sinatra::Base

    require 'liprug/model'
    require 'liprug/service/helpers'
    require 'liprug/service/routes'
  end
end
