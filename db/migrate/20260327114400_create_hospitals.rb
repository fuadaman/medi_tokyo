class CreateHospitals < ActiveRecord::Migration[7.1]
  def change
    create_table :hospitals do |t|
      t.string :name_en
      t.string :name_jp
      t.string :address_en
      t.string :address_jp
      t.string :phone
      t.string :website_url
      t.string :ward
      t.float :latitude
      t.float :longitude
      t.string :visiting_hours

      t.timestamps
    end
  end
end
