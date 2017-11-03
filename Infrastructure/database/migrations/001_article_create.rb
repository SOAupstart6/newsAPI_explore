require 'sequel'

Sequel.migration do
  change do
    create_table(:article) do
      primary_key :id
      String :source
      String :title
      String :description
      String :url
      String :urlToImage
      String :author
      String :publishedAt
      DateTime :created_at
      DateTime :updated_at
    end
  end
end