# frozen_string_literal: true

class Application::Event < ActiveRecord::Base
  belongs_to :application

  # TODO: add :method_missing and :respond_to? to retrieve property
end
