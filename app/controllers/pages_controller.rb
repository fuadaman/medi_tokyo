class PagesController < ApplicationController
  def home
    @hospitals = Hospital.includes(:specialties).all
    @emergency_contacts = EmergencyContact.all
  end

  def emergency
    @emergency_contacts = EmergencyContact.all
  end
end
