require 'hurley'
require 'json'
require 'uri'

module Dorans

  # Single-entry point client to interact with the Riot Games API
  class Client

    # @return [String] The API key provided
    attr_reader :api_key

    # @return [String] The region to retrieve data from
    attr_reader :region

    # @return [Hurley::Client] The Hurley HTTP Client object
    attr_reader :http

    # Initialize a new Client to interact with the Riot Games API
    # @param api_key [#to_s] The API key for your Riot Games Application
    # @param region [#to_s] The region to perform requests on
    def initialize(api_key, region = 'na')
      @api_key = api_key
      @region = region
      @http = Hurley::Client.new
      @http.header[:content_type] = 'application/json'
      @http.query['api_key'] = api_key
    end

    # Pretty-printed string representation of Dorans::Client object
    def to_s
      "#<Dorans::Client api_key=#{api_key[0..7]}... region=#{region} >"
    end
    alias_method :inspect, :to_s

    # @return [#to_s] The Riot API host url to perform requests on
    def api_url
      "https://#{region}.api.pvp.net/api/lol/#{region}"
    end

    # @param name [#to_s] The summoner name to search for
    def find_player(name)
      path = ['v1.4', 'summoner', 'by-name', name]
      send_request path
    end

    def get_player(id)
      path = ['v1.4', 'summoner', id]
      send_request path
    end

    def recent_games(id)
      path = ['v1.3', 'game', 'by-summoner', id, 'recent']
      send_request path
    end

    # @param id [#to_i] Match ID
    # @param timeline [Boolean] Include match timeline data
    # @return [Dorans::Match::Detail]
    def match(id, timeline = false)
      path = ['v2.2', 'match', id]
      options = { query: { includeTimeline: timeline } }
      response = send_request path, options
      Match::Detail.new(response)
    end

    # @param path [Array<#to_s>] Path segments for the request's URI.
    # @return [Dorans::API::Response]
    def send_request(path, options = {})
      path = ["#{api_url}"].concat(
        path.map { |s| URI.escape(s.to_s).gsub('/', '%2F') }).join('/')

      query_string = options.fetch(:query, {})
      response = http.get path, query_string

      response_class = options.fetch(:response, API::Response)
      response_class.new(response, self)
    end

  end

end
