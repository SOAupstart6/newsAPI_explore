require 'sequel'

Sequel.migration do
  change do
    create_table(:article) do
      primary_key :id

      String :title
      String :descr
      String :url
      String :img_url
      DateTime :created_at
      DateTime :updated_at
    end
  end
end