module NewsCollect
    # Representer for HTTP response information
    class HttpResponseRepresenter < Roar::Decorator
        include Roar::JSON
    
        property :code
        property :message
    
        HTTP_CODE = {
          ok: 200,
          created: 201,
          processing: 202,
    
          cannot_process: 422,
          not_found: 404,
          bad_request: 400,
          conflict: 409,
    
          internal_error: 500
        }.freeze
    
        def http_code
          HTTP_CODE[@represented.code]
        end
    
        private
    
        def http_success?
          http_code < 300
        end
    
        def http_message
          { msg_or_error => @represented.message }
        end
    
        def msg_or_error
          http_success? ? :message : :error
        end
      end
    end
end