module ApplicationHelper
  def locale_field(record, field)
    if I18n.locale == :ja
      record.send("#{field}_jp") rescue record.send("#{field}_en")
    else
      record.send("#{field}_en")
    end
  end

  # "Chiyoda Ward" => "chiyoda-ward", "Fuchu City" => "fuchu-city"
  def ward_anchor(ward)
    ward.to_s.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/-+\z/, "")
  end

  # "Chiyoda Ward" => "Chiyoda", "Fuchu City" => "Fuchu"
  def ward_short_name(ward)
    ward.to_s.sub(/ Ward\z/, "").sub(/ City\z/, "")
  end

  # Parse "Languages: English; Chinese; Korean" -> ["English", "Chinese", "Korean"]
  # Returns [] for nil, blank, or non-language notes fields.
  def parse_languages(notes)
    return [] unless notes.present? && notes.start_with?("Languages:")
    notes.sub(/\ALanguages:\s*/, "").split(";").map(&:strip).reject(&:blank?)
  end

  # Derive a human-readable facility type from the name.
  def hospital_type_label(hospital)
    name = hospital.name_en.to_s.downcase
    if    name.include?("dental")                     then "Dental"
    elsif name.include?("hospital")                   then "Hospital"
    elsif name.include?("clinic")                     then "Clinic"
    elsif name.include?("medical center") ||
          name.include?("medical centre")             then "Med Center"
    elsif name.include?("pharmacy") ||
          name.include?("dispensary")                 then "Pharmacy"
    else                                                   "Medical"
    end
  end

  # CSS modifier for the type badge colour.
  def hospital_type_css(hospital)
    case hospital_type_label(hospital)
    when "Hospital"   then "hospital"
    when "Dental"     then "dental"
    when "Clinic"     then "clinic"
    when "Med Center" then "center"
    else                   "other"
    end
  end
end
