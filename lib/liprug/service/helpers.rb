require 'sinatra'
require 'liprug/config'

module Liprug
  class Service < Sinatra::Base
    helpers do

      def authorized?
        creds = (Liprug::Config['LIPRUG_CREDENTIALS'] || ":").split ":"
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == creds
      end

      def protected!
        return if authorized?
        headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
        halt 401, "Not authorized"
      end
    end
  end
end
