require 'dry/transaction'

module NewsCollect
    class LoadFromNewsapi
        include Dry::Transaction

        step :get_news_from_newsapi
        step :check_if_news_loaded
        step :store_news

        def get_news_from_newsapi(input)
            news = NewsApi::NewsMapper.new(input[:config]).find(input[:id])
            
            Right(news: news)
        rescue StandardError
            Left(Result.new(:bad_request, 'news not found'))
        end

        def check_if_news_always_loaded(input)
            if Repository::For[input[:news_Entity].class].find(input[:news_Entity])
                Left(Result.new(:conflict, 'news already loaded'))
            else
                Right(input)
            end
        end

        def store_news(input)
            stored_news = Repository::For[input[:news_Entity].class].create(input[:news_Entity])
            Right(Result.new(:create, stored_news))
        rescue StandardError => e
            puts e.to_s
            Left(Result.new(:internal_error,'Could not store news'))
        end
    end
end