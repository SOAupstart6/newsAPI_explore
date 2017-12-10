module NewsCollect
  module NewsApi
    class NewsMapper
        def initialize(config, gateway_class = NewsApi::Api)
          @config = config
          @gateway_class = gateway_class 
          @gateway = @gateway_class.new(@config.token)
        end

        def load(source)
          news_data = @gateway.news_data(source)
          build_entity(news_data)
        end

        def build_entity(news_data)
            Datamapper.new(news_data).build_entity
        end
       
        class Datamapper
           def initialize(news_data)
               @news_data = news_data
           end
           
           def build_entity
            NewsPraise::Entity::New(
            id: nil,
            source: source,
            sortBy: sortBy,
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt
            )
           end


           def source
            @news_data['source']
           end

           def sortBy
            @news_data['sortBy']
           end

           def author
            @news_data['articles']['author']
           end

           def title
            @news_data['articles']['title']
           end

           def description
            @news_data['articles']['description']
           end

           def url
            @news_data['articles']['url']
           end

           def urlToImage
            @news_data['articles']['urlToImage']
           end

           def publishedAt
            @news_data['articles']['publishedAt']
           end
        end
      end
    end
end



