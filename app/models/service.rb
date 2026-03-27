class Service < ApplicationRecord
  has_many :hospital_services
  has_many :hospitals, through: :hospital_services
end
