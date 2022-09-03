# frozen_string_literal: true

module Schools
  class Search
    def initialize(search_query:, page:, per_page:)
      @search_query = search_query
      @page = page || 0
      @per_page = per_page || 20
    end

    def schools
      if search_result.success
        search_result.schools
      else
        []
      end
    end

    def total
      if search_result.success
        search_result.total
      else
        0
      end
    end

    private

    attr_reader :search_query, :page, :per_page

    def search_result
      @search_result ||= college_scorecard_client.search_schools(name: search_query, page: page, per_page: per_page)
    end

    def college_scorecard_client
      @college_scorecard_client ||= CollegeScorecard::Client.new
    end
  end
end
