module NewsCollect
    module Database
        class NewsOrm < Sequel::Model(:article)
            plugin :timestamps, update_on_create: true
        end
    end
end