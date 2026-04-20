class AddDepartmentsToHospitals < ActiveRecord::Migration[7.1]
  def change
    add_column :hospitals, :departments, :text
  end
end
