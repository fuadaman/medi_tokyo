class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :name_en
      t.string :name_jp
      t.string :category

      t.timestamps
    end
  end
end
