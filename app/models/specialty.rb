class Specialty < ApplicationRecord
  has_many :hospital_specialties
  has_many :hospitals, through: :hospital_specialties
end
