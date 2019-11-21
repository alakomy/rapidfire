class AddApiIdToRapidfireSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :rapidfire_surveys, :api_id, :uuid, default: 'uuid_generate_v4()'
  end
end
