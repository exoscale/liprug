require 'redis'
require 'json'
require 'uri'
require 'liprug/config'

module Liprug
  class Model
    def self.connect!
        url = Liprug::Config['REDISTOGO_URL']
        url ||= Liprug::Config['REDIS_URL'] 
        url ||= "redis://127.0.0.1"

	uri = URI.parse(url)
	options = {:host => uri.host}
	options[:port] = uri.port if uri.port
	options[:password] = uri.password if uri.password

	Redis.new(options)
    end	

    def self.fetch
      redis = connect!
      services = redis.smembers 'services'
      {
	:brand => {
          :script => Liprug::Config['LIPRUG_BRAND_SCRIPT'] || '',
	  :name => Liprug::Config['LIPRUG_BRAND_HEADER'] || 'status board',
	  :contact => Liprug::Config['LIPRUG_BRAND_CONTACT']
	},
        :services => services.map do |service|
          {
            service => JSON.parse(redis.get("service:#{service}"),
                                    :symbolize_names => true)
          }
        end.reduce({}) do |e1,e2|
          e1.merge e2
        end,
        :past => redis.lrange('events_past', 0, -1).map do |event|
          JSON.parse event, :symbolize_names => true
        end,
        :upcoming => redis.lrange('events_upcoming', 0, -1).map do |event|
          JSON.parse event, :symbolize_names => true
        end
      }
    end

    def self.add_status service, status
      redis = connect!
      redis.sadd "services", service
      redis.set "service:#{service}", status.to_json
    end

    def self.delete_service service
      redis = connect!
      redis.srem "services", service
      redis.del "service:#{service}"
    end
    
    def self.add_upcoming_event event
      redis = connect!
      event[:date] = Time.new.asctime
      event = event.to_json
      redis.lpush "events_upcoming", event
    end

    def self.add_past_event event
      redis = connect!
      event[:date] = Time.new.asctime
      event = event.to_json
      redis.lpush "events_past", event
    end

    def self.delete_upcoming_event index
      redis = connect!
      redis.lset "events_upcoming", index, "XXXXX"
      redis.lrem "events_upcoming", 1, "XXXXX"
    end

    def self.delete_past_event index
      redis = connect!
      redis.lset "events_past", index, "XXXXX"
      redis.lrem "events_past", 1, "XXXXX"
    end

  end
end
