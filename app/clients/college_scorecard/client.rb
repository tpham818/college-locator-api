# frozen_string_literal: true

require 'httparty'

module CollegeScorecard
  class Client
    include HTTParty

    default_timeout 5

    def initialize
      self.class.base_uri 'https://api.data.gov/ed/collegescorecard/v1/'
      @api_key = ENV.fetch('COLLEGE_SCORECARD_API_KEY', '')
    end

    def search_schools(name:, page:, per_page:)
      path = '/schools'
      query_params = {
        'school.name' => name,
        'page' => page,
        'per_page' => per_page
      }

      response = self.class.get(path, { query: query.merge(query_params) })

      case response.code
      when 200
        SchoolsResponse.new(response)
      else
        Rails.logger.error('CollegeScorecard API Failure.  Response: response')
        SchoolsResponse.api_failure
      end
    end

    private

    def query
      { 'api_key' => @api_key }
    end
  end
end
