class HospitalService < ApplicationRecord
  belongs_to :hospital
  belongs_to :service
end
