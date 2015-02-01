require 'forwardable'
require 'hurley'
require 'json' unless defined?(::JSON)

module Dorans::API

  # A generic response from the API.
  class Response

    extend Forwardable
    def_delegators :@response, :status_code, :header, :success?
    # @!attribute [r] status_code
    #   @return [Integer] The HTTP Status code of the response.
    # @!attribute [r] body
    #   @return [Hash, String] The response body, de-serialized from JSON.
    # @!attribute [r] header
    #   @return [Hash{String => String}] The response headers
    # @!method success?()
    #   @return [true, false] If the response is 1xx-3xx class response,
    #     or a 4xx-5xx class response.

    # @return [Time] The time at which the response was made.
    attr_reader :request_time

    # @return [Dorans::Client] The client used to generate the response.
    attr_reader :client

    # @return [String, Hash] The response body from Orchestrate
    attr_reader :body

    # Instantiate a new Respose
    # @param hurley_response [Hurley::Response] The Hurley response object.
    # @param client [Dorans::Client] The client used to generate the response.
    def initialize(hurley_response, client)
      @client = client
      @response = hurley_response
      @request_time = Time.parse(header['Date']) if header['Date']
      @body = JSON.parse(@response.body)
      # handle_error_response unless success?
    end

    # @!visibility private
    def to_s
      "#<#{self.class.name} status_code=#{status_code} request_time=#{request_time}>"
    end
    alias_method :inspect, :to_s

    # private

    # def handle_error_response
    #   err_type = if body && body['code']
    #     ERRORS.find {|err| err.status == status && err.code == body['code'] }
    #   else
    #     errors = ERRORS.select {|err| err.status == status}
    #     errors.length == 1 ? errors.first : nil
    #   end
    #   if err_type
    #     raise err_type.new(self)
    #   elsif status < 500
    #     raise RequestError.new(self)
    #   else
    #     raise ServiceError.new(self)
    #   end
    # end

  end

  # A generic response for a Match entity
  class MatchResponse < Response

  end

end
