module NewsCollect
    class NewsRepresenter < Roar::Decorator
        include Roar::JSON
        
        property :source
        property :author
        property :title
        property :description
        property :url
        property :urlToImage
    end
end
