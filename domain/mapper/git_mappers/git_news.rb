# frozen_string_literal: true

module NewsCollect
  class GitNews
    MAX_SIZE = 1000 # for cloning, analysis, summaries, etc.

    class Errors
      NoGitNewsFound = Class.new(StandardError)
      TooLargeToClone = Class.new(StandardError)
      CannotOverwriteLocalNews = Class.new(StandardError)
    end

    def initialize(repo, config = NewsCollect::Api.config)
      @news = news
      origin = Git::RemoteNews.new(@news.git_url)
      @local = Git::LocalNews.new(origin, config.NEWSSTORE_PATH)
    end

    def local
      raise Errors::NoGitNewsFound unless exists_locally?
      @local
    end

    def delete!
      @local.delete!
    end

    def too_large?
      @repo.size > MAX_SIZE
    end

    def exists_locally?
      @local.exists?
    end

    def clone!
      raise Errors::TooLargeToClone if too_large?
      raise Errors::CannotOverwriteLocalNews if exists_locally?
      @local.clone_remote
    end
  end
end
