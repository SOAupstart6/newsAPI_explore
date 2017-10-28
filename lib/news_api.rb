#
module NewsPraise
   module NewsApi
      class Api
        module Errors
            # Not allowed to access resource
            Unauthorized = Class.new(StandardError)
            # Requested resource not found
            NotFound = Class.new(StandardError)
        end
    
          # Encapsulates API response success and errors
        class Response
           HTTP_ERROR = {
              401 => Errors::Unauthorized,
              404 => Errors::NotFound
            }
    
           def initialize(response)
              @response = response
           end
    
            def successful?
              HTTP_ERROR.keys.include?(@response.code) ? false : true
            end
    
            def response_or_error
              successful? ? @response : raise(HTTP_ERROR[@response.code])
            end
          end

        def initialize(token)
           @token = token
        end

        def news_data(source)
           news_req_url = Api.news_path(source)
           call_url(news_req_url).parse
        end  
          
        def self.news_path(path,token)
           "https://newsapi.org/v1/articles?source="+path+"&sortBy=top&apiKey="+token
        end 

        def call_url(url)
           response = HTTP.headers('Accept' => 'application/json').get(url)
           Response.new(response).response_or_error
        end
       end
    end
end
