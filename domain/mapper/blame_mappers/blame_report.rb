# frozen_string_literal: true

require 'concurrent'

module NewsCollect
  module Blame
    # Git blame parsing and reporting services
    class Reporter
      def initialize(gitnews)
        @local = gitnews.local
      end

      def folder_report(folder_name)
        folder_name = '' if folder_name == '/'
        files = @local.files.select { |file| file.start_with? folder_name }
        @local.in_news do
          files.map do |filename|
            Concurrent::Promise.execute { [filename, file_report(filename)] }
          end.map(&:value)
        end.to_h
      end

      def files(folder_name)
        @local.files.select { |file| file.start_with? folder_name }
      end

      def subfolders(folder_name)
        @local.folder_structure[folder_name]
      end

      def folder_structure
        @local.folder_structure
      end

      def file_report(filename)
        blame_output = Git::NewsFile.new(filename).blame
        Porcelain.parse_file_blame(blame_output)
      end
    end
  end
end
