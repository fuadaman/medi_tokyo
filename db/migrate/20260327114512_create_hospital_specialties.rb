class CreateHospitalSpecialties < ActiveRecord::Migration[7.1]
  def change
    create_table :hospital_specialties do |t|
      t.references :hospital, null: false, foreign_key: true
      t.references :specialty, null: false, foreign_key: true

      t.timestamps
    end
  end
end
