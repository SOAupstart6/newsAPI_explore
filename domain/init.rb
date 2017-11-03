# frozen_string_literal: true

folders = %w[Entity mapper]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end