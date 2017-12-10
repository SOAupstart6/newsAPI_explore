# frozen_string_literal: false

folders = %w[news database/orm]
#folders = %w[news database/orm]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end