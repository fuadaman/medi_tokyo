class CreateSpecialties < ActiveRecord::Migration[7.1]
  def change
    create_table :specialties do |t|
      t.string :name_en
      t.string :name_jp

      t.timestamps
    end
  end
end
