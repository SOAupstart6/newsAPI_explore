require 'roda'

module NewsCollect
  # Web API
  class Api < Roda
    route do |routing|
      app = Api
      response['Content-Type'] = 'application/json'

      # GET / request
      routing.root do
        message = "NewsCollect API v0.1 up in #{app.environment} mode"
        HttpResponseRepresenter.new(Result.new(:ok, message)).to_json
      end

      routing.on 'api' do
        # /api/v0.1 branch
        routing.on 'v0.1' do
          routing.on 'source' do
            # /api/v0.1/source index request
            routing.is do
              routing.get do
                source = Repository::For[Entity::News].all
                SourceRepresenter.new(Repos.new(source)).to_json
              end
            end

            # /api/v0.1/source/:id branch
            routing.on String do |id|
              # GET /api/v0.1/source/:id request
              routing.get do
                find_result = findDatabaseNews.call(
                  id: id
                )

                http_response = HttpResponseRepresenter.new(find_result.value)
                response.status = http_response.http_code
                if find_result.success?
                  SourceRepresenter.new(find_result.value.message).to_json
                else
                  http_response.to_json
                end
              end

              # POST '/api/v0.1/source/:id request
              routing.post do
                service_result = LoadFromNewsapi.new.call(
                  config: app.config,
                  id: id
                )

                http_response = HttpResponseRepresenter.new(service_result.value)
                response.status = http_response.http_code
                if service_result.success?
                  response['Location'] = "/api/v0.1/source/#{id}"
                  SourceRepresenter.new(service_result.value.message).to_json
                else
                  http_response.to_json
                end
              end
            end
          end
        end
      end
    end
  end
end