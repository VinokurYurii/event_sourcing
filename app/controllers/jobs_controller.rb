# frozen_string_literal: true

class JobsController < ApplicationController
  def activated_with_applications
    render json: GetActiveJobApplicationsService.call, each_serializer: ApplicationSerializer
  end
end
