# frozen_string_literal: true

module ControllerHelpers
  def json_response
    parsed_response = JSON.parse(response.body)

    return parsed_response.map(&:deep_symbolize_keys) if parsed_response.is_a?(Array)

    parsed_response.deep_symbolize_keys
  end
end

RSpec.configure do |config|
  config.include ControllerHelpers, type: :controller
end
