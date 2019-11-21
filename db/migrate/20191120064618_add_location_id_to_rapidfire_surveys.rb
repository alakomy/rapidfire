class AddLocationIdToRapidfireSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :rapidfire_surveys, :location_id, :integer
  end
end
