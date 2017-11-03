# frozen_string_literal: false
require 'dry-types'

module NewsCollect
  module Entity
    # Add dry types to Entity module
    module Types
      include Dry::Types.module
    end
  end
end

require_relative 'news_Entity.rb'