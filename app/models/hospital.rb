class Hospital < ApplicationRecord
  has_many :hospital_specialties
  has_many :specialties, through: :hospital_specialties
  has_many :hospital_services
  has_many :services, through: :hospital_services
end
