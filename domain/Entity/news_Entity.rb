require 'dry-struct'

module NewsCollect
    module Entity
        class News < Dry::Struct
            attribute :source, Types::Strict::String
            attribute :sortBy, Types::Strict::String
            attribute :author, Types::Strict::String
            attribute :title, Types::Strict::String
            attribute :description, Types::Strict::String
            attribute :url, Types::Strict::String
            attribute :urlToImage, Types::Strict::String
            attribute :publishedAt, Types::Strict::String
        end
    end
end