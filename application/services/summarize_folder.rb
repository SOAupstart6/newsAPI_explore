# frozen_string_literal: true

require 'dry/transaction'

module NewsCollect
  # Transaction to summarize folder from local repo
  class SummarizeFolder
    include Dry::Transaction

    step :clone_or_find_news
    step :summarize_folder

    def clone_or_find_news(input)
      input[:gitnews] = GitNews.new(input[:news])
      if input[:gitnews].exists_locally?
        Right(input)
      else
        repo_json = NewsRepresenter.new(input[:news]).to_json
        CloneNewsWorker.perform_async(repo_json)
        Left(Result.new(:processing, 'Processing the summary request'))
      end
    rescue
      Left(Result.new(:internal_error, 'Could not clone repo'))
    end

    def summarize_folder(input)
      folder_summary = Blame::Summary
                       .new(input[:gitnews])
                       .for_folder(input[:folder])
      Right(Result.new(:ok, folder_summary))
    rescue
      Left(Result.new(:internal_error, 'Could not summarize folder'))
    end
  end
end
