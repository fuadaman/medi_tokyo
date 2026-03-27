class HospitalsController < ApplicationController
  def index
    @hospitals = Hospital.includes(:specialties, :services).all
  end

  def show
    @hospital = Hospital.includes(:specialties, :services).find(params[:id])
  end
end
