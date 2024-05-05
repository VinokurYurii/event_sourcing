# frozen_string_literal: true

class ApplicationsController < ApplicationController
  def index
    render json: GetActivatedApplicationsService.call, each_serializer: ApplicationSerializer
  end
end
