class AddInsuranceFieldsToHospitals < ActiveRecord::Migration[7.1]
  def change
    add_column :hospitals, :is_government, :boolean
    add_column :hospitals, :is_certified, :boolean
    add_column :hospitals, :accepts_shakai_hoken, :boolean
    add_column :hospitals, :accepts_kokumin_hoken, :boolean
    add_column :hospitals, :accepts_travel_insurance, :boolean
    add_column :hospitals, :insurance_notes_en, :string
    add_column :hospitals, :insurance_notes_jp, :string
  end
end
