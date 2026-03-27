class HospitalSpecialty < ApplicationRecord
  belongs_to :hospital
  belongs_to :specialty
end
