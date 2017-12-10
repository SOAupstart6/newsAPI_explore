require 'dry-monads'

module NewsCollect
    module findDatabaseNews
        extend Dry::Monads::Either::Mixin

        def self.call(input)
            news = Repository::For[Entity::news_Entity].find_id(input[:id])

            if news
                Right(Result.new(:ok, news))
            else
                Left(Result.new(:not found, 'news not found'))
            end
        end
    end
end
