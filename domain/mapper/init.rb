folders = %w[news_mappers git_mappers blame_mappers]

folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
