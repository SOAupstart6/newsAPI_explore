module NewsCollect
    module Repositories
        class News_sources
            #unique attubute
             def self.all
                Database::NewsOrm.all.map { |db_news| rebuild_entity(db_news) }
            end
            
            def self.find(entity)
                find_id(entity.id)
            end
            
            def self.find_id(id)
                db_record = Database::NewsOrm.first(id: id)
                rebuild_entry(db_record)
            end

            def self.find_or_create(entity)
                find_or_create(entity.id) || create(entity)
            end

            def self.create(entity)
                raise 'news already exists' if find(entity)
                
                db_news = Database::NewsOrm.create(
                source: entity.source,
                title: entity.title,
                description: entity.description,
                url: entity.url,
                urlToImage: entity.urlToImage,
                author: entity.author,
                publishedAt: entity.publishedAt
                )
                
                self.rebuild_entity(db_news)
            end

            def self.rebuild_entity(db_record)
                return nil unless db_record

                Entity::news_Entity.new(
                    source: db_record.source,
                    title: db_record.title,
                    description: db_record.description,
                    url: db_record.url,
                    urlToImage: db_record.urlToImage,
                    author: db_record.author,
                    publishedAt: db_record.publishedAt
                )
            end
        end            
    end
end
