module Dorans::Match

  # Base Match Detail object
  # Riot URL: '/api/lol/{region}/v2.2/match/{matchId}'
  class Detail

    # The client which performed the request
    # @return [Dorans::Client]
    attr_reader :client

    # The API response body
    # @return [Hash]
    attr_reader :listing

    # Game ID
    # @return [Interger]
    attr_reader :id

    # Match Mode
    # Legal values from the Riot API Documentation:
    #   'CLASSIC', 'ODIN', 'ARAM', 'TUTORIAL', 'ONEFORALL',
    #   'ASCENSION', 'FIRSTBLOOD', 'KINGPORO'
    # @return [String]
    attr_reader :mode

    # The Match type
    # @return [String]
    attr_reader :type

    # Match creation time.
    # Recorded when the team select lobby is created,
    # and/or the match is made through match making
    # @return [Time]
    attr_reader :created_at

    # Duration of the match
    # @return [Time]
    attr_reader :duration

    # Queue type
    # @return [String]
    attr_reader :queue

    # Region where the match was played
    # @return [String]
    attr_reader :region

    # Season the match was played
    # @return [String]
    attr_reader :season

    # Patch version of the match
    # @return [String]
    attr_reader :version

    # Platform ID of the match
    # @return [String]
    attr_reader :platform_id

    # Instantiate a new Match object from a Match or MatchHistory response
    # @return [Match::Detail]
    def initialize(listing)
      @listing = listing
      @id = listing['matchId']
      @mode = listing['matchMode']
      @type = listing['matchType']
      @created_at = listing['matchCreation']
      @duration = listing['matchDuration']
      @queue = listing['queueType']
      @season = listing['season']
      @version = listing['matchVersion']
      @platform_id = listing['platformId']
    end

    # Pretty-printed string representation of Match::Detail object
    def to_s
      "#<Dorans::Match::Detail id=#{id} region=#{region} queue=#{queue} created_at=#{created_at} >"
    end
    alias_method :inspect, :to_s

    # @return [Match::BlueTeam]
    def blue_team
    end

    # @return [Match::RedTeam]
    def red_team
    end

    # @return [Array<Match::Player>]
    def players
    end

    # @return [Match::Timeline]
    def timeline
    end

  end

end
