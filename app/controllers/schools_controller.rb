# frozen_string_literal: true

class SchoolsController < ApplicationController
  def index
    school_search_result = Schools::Search.new(search_query: school_search_query, page: params[:page],
                                               per_page: params[:per_page])
    render json: { schools: school_search_result.schools, total: school_search_result.total }
  end

  private

  def school_search_query
    params.require(:query)
  end
end
