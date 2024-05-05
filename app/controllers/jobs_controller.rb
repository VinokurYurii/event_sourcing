# frozen_string_literal: true

class JobsController < ApplicationController
  def index
    render json: GetJobStatisticsService.call, each_serializer: JobStatisticsSerializer
  end
end
