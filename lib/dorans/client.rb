require "hurley"
require "uri"

module Dorans
  # Single-entry point client to interact with the Riot Games API
  class Client
    
    # @return [String] The API key provided
    attr_reader :api_key

    # @return [String] The region to retrieve data from
    attr_reader :region

    # @return [Hurley::Client]
    attr_reader :http

    # Initialize a new Client to interact with the Riot Games API
    # @param api_key [#to_s] The API key for your Riot Games Application
    # @param 
    def initialize(api_key, region="na")
      @api_key = api_key
      @region = region
      @http = Hurley::Client.new 
      @http.header[:content_type] = "application/json"
      @http.query["api_key"] = api_key
    end

    # Pretty-printed string representation of Dorans::Client object
    def to_s
      "#<Dorans::Client api_key=#{api_key[0..7]}... region=#{region} >"
    end
    alias :inspect :to_s

    # @return [#to_s] The Riot API host url to perform requests on
    def api_url
      "https://#{region}.api.pvp.net/api/lol/#{region}"
    end

    # @param name [#to_s] The summoner name to search for
    def find_summoner_by_name(name)
      send_request ['v1.4', 'summoner', 'by-name', name]
    end

    # @param path [Array<#to_s>] Path segments for the request's URI.  Prepended by 'api_url'.
    # @return Hurley::Response
    def send_request(path)
      path = ["#{api_url}"].concat(path.map{|s| URI.escape(s.to_s).gsub('/','%2F') }).join('/')
      http.get(path)
    end
  end

end