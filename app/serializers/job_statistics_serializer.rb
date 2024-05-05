# frozen_string_literal: true

class JobStatisticsSerializer < ActiveModel::Serializer
  attributes :title, :status, :hired, :rejected, :ongoing
end
