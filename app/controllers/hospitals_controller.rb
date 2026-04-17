class HospitalsController < ApplicationController
  # Official Tokyo 23-ward administrative order.
  # Ward names match the values stored in the `ward` DB column (from JSON keys).
  WARD_ORDER = [
    "Chiyoda Ward", "Chuo Ward", "Minato Ward", "Shinjuku Ward", "Bunkyo Ward",
    "Taito Ward", "Sumida Ward", "Koto Ward", "Shinagawa Ward", "Meguro Ward",
    "Ota Ward", "Setagaya Ward", "Shibuya Ward", "Nakano Ward", "Suginami Ward",
    "Toshima Ward", "Kita Ward", "Arakawa Ward", "Itabashi Ward", "Nerima Ward",
    "Adachi Ward", "Katsushika Ward", "Edogawa Ward"
  ].freeze

  def index
    # One query — group in Ruby to avoid N+1 per ward.
    all_hospitals = Hospital.includes(:specialties, :services)
                            .order(:name_en)
                            .to_a

    grouped = all_hospitals.group_by(&:ward)

    # 23 wards first, in canonical order; only include wards that actually have data.
    ward_groups = WARD_ORDER.filter_map do |ward_name|
      entries = grouped[ward_name]
      [ward_name, entries] if entries.present?
    end

    # Everything else (outside-23-ward cities) sorted alphabetically.
    outside_groups = grouped
      .reject { |ward, _| WARD_ORDER.include?(ward) }
      .sort_by { |ward, _| ward.to_s }
      .map { |ward, hospitals| [ward, hospitals.sort_by(&:name_en)] }

    @hospitals_by_location = ward_groups + outside_groups
    @total_count = all_hospitals.size
  end

  def show
    @hospital = Hospital.includes(:specialties, :services).find(params[:id])

    # Up to 5 sibling institutions in the same ward/city, excluding self.
    @ward_siblings = Hospital
      .where(ward: @hospital.ward)
      .where.not(id: @hospital.id)
      .order(:name_en)
      .limit(5)
  end
end
