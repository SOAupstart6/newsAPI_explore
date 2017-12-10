module NewsCollect
  module Blame
    # Git blame parsing and reporting services
    class Summary
      def initialize(gitrepo)
        @gitnews = gitnews
      end

      def for_folder(folder_name)
        blame_reports = Blame::Reporter.new(@gitnews).folder_report(folder_name)
        Entity::FolderSummary.new(@news, folder_name, blame_reports)
      end
    end
  end
end
