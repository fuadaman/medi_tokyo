class CreateInsuranceGuides < ActiveRecord::Migration[7.1]
  def change
    create_table :insurance_guides do |t|
      t.string :title_en
      t.string :title_jp
      t.text :body_en
      t.text :body_jp
      t.string :insurance_type
      t.integer :coverage_percent

      t.timestamps
    end
  end
end
