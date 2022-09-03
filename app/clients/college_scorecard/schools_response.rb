# frozen_string_literal: true

module CollegeScorecard
  class SchoolsResponse
    School = Struct.new(:id, :name, :location)
    Location = Struct.new(:lat, :lon)

    attr_reader :success

    def self.api_failure
      new(nil, success = false)
    end

    def initialize(raw_response, success = true)
      @raw_response = raw_response
      @success = success
    end

    def schools
      raw_response.fetch('results', []).map do |result|
        id = result['id']
        name = result.dig('school', 'name')
        lat = result.dig('location', 'lat')
        lon = result.dig('location', 'lon')

        School.new(id, name, Location.new(lat, lon)) if id && name && lat && lon
      end.compact
    end

    def total
      raw_response.dig('metadata', 'total')
    end

    private

    attr_reader :raw_response
  end
end
