class CreateEmergencyContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :emergency_contacts do |t|
      t.string :name_en
      t.string :name_jp
      t.string :number
      t.string :description_en
      t.string :description_jp

      t.timestamps
    end
  end
end
