# =============================================================
# MediTokyo - db/seeds.rb
# Hospital source: db/tokyo_medical_seed.json
# Reference data: emergency contacts, specialties, services,
#                 insurance guides (defined inline below)
# =============================================================

puts "Clearing all data..."
HospitalService.destroy_all
HospitalSpecialty.destroy_all
Hospital.destroy_all
Service.destroy_all
Specialty.destroy_all
EmergencyContact.destroy_all
InsuranceGuide.destroy_all

# =============================================================
# EMERGENCY CONTACTS
# =============================================================
puts "Creating emergency contacts..."
EmergencyContact.create!([
  {
    name_en: "Ambulance & Fire",
    name_jp: "救急・消防",
    number: "119",
    description_en: "Call for ambulance or fire emergency. English operator available 24 hours.",
    description_jp: "救急車または火災の緊急時に電話してください。英語対応24時間。"
  },
  {
    name_en: "Police",
    name_jp: "警察",
    number: "110",
    description_en: "Call for police emergency.",
    description_jp: "警察の緊急時に電話してください。"
  },
  {
    name_en: "Tokyo Medical Information (Himawari)",
    name_jp: "東京都医療機関案内（ひまわり）",
    number: "03-5285-8181",
    description_en: "Tokyo Metropolitan Health & Medical Information Center. Available 9am-8pm. English, Chinese, Korean, Thai, Spanish.",
    description_jp: "東京都医療機関案内サービス。9時〜20時対応。英語・中国語・韓国語・タイ語・スペイン語対応。"
  },
  {
    name_en: "Tokyo Emergency Interpreter",
    name_jp: "東京救急通訳",
    number: "03-5285-8185",
    description_en: "Emergency telephone interpreting for medical situations. Weekdays 5pm-8pm, Weekends 9am-8pm.",
    description_jp: "救急医療通訳電話サービス。平日17時〜20時、土日祝9時〜20時。"
  },
  {
    name_en: "Tokyo English Lifeline",
    name_jp: "東京英語いのちの電話",
    number: "03-5774-0992",
    description_en: "English counseling and emotional support.",
    description_jp: "英語によるカウンセリングと緊急サポート。"
  }
])

# =============================================================
# SPECIALTIES
# =============================================================
puts "Creating specialties..."
Specialty.create!([
  { name_en: "Cardiology",             name_jp: "循環器科" },
  { name_en: "Orthopedics",            name_jp: "整形外科" },
  { name_en: "Pediatrics",             name_jp: "小児科" },
  { name_en: "Oncology",               name_jp: "腫瘍科" },
  { name_en: "Emergency Medicine",     name_jp: "救急科" },
  { name_en: "Neurology",              name_jp: "神経科" },
  { name_en: "Psychiatry",             name_jp: "精神科" },
  { name_en: "Maternity & Obstetrics", name_jp: "産婦人科・周産期" },
  { name_en: "Pediatrics & Newborn",   name_jp: "小児科・新生児科" },
  { name_en: "Infectious Diseases",    name_jp: "感染症科" },
  { name_en: "Rehabilitation",         name_jp: "リハビリ科" },
  { name_en: "Gynecology",             name_jp: "婦人科" }
])

# =============================================================
# SERVICES
# =============================================================
puts "Creating services..."
Service.create!([
  { name_en: "Outpatient Care",    name_jp: "外来診療",   category: "general" },
  { name_en: "Inpatient Care",     name_jp: "入院診療",   category: "general" },
  { name_en: "MRI Scan",           name_jp: "MRI検査",    category: "diagnostic" },
  { name_en: "X-Ray",              name_jp: "レントゲン", category: "diagnostic" },
  { name_en: "CT Scan",            name_jp: "CT検査",     category: "diagnostic" },
  { name_en: "Surgery",            name_jp: "外科手術",   category: "surgical" },
  { name_en: "Rehabilitation",     name_jp: "リハビリ",   category: "recovery" },
  { name_en: "24h Emergency Care", name_jp: "24時間救急", category: "emergency" },
  { name_en: "Prenatal Care",      name_jp: "産前ケア",   category: "maternity" },
  { name_en: "Vaccination",        name_jp: "予防接種",   category: "preventive" }
])

# =============================================================
# INSURANCE GUIDES
# Source: MHLW, nenkin.go.jp, e-housing.jp
# =============================================================
puts "Creating insurance guides..."
InsuranceGuide.create!([
  {
    title_en: "Shakai Hoken (社会保険)",
    title_jp: "社会保険",
    body_en: "Shakai Hoken is company-sponsored health insurance in Japan. If you are employed full-time, your employer enrolls you automatically. It covers 70% of all medical costs — you only pay 30% out of pocket. For children, the co-pay is reduced to 20%. Bring your insurance card (保険証) to every hospital visit. Important: normal childbirth costs are not covered directly — instead you receive a lump-sum maternity allowance of 500,000 yen (出産育児一時金) per baby.",
    body_jp: "社会保険は会社が加入する健康保険です。フルタイム勤務の場合、雇用主が自動的に加入手続きを行います。医療費の70%をカバーし、自己負担は30%です。子どもの場合は自己負担が20%に軽減されます。病院受診の際は必ず保険証をお持ちください。重要：通常の出産費用は直接カバーされませんが、代わりに赤ちゃん1人につき50万円の出産育児一時金が支給されます。",
    insurance_type: "shakai_hoken",
    coverage_percent: 70
  },
  {
    title_en: "Kokumin Hoken (国民健康保険)",
    title_jp: "国民健康保険",
    body_en: "Kokumin Hoken is the national health insurance for self-employed people, part-time workers, students, and foreigners staying longer than 3 months. It also covers 70% of medical costs — you pay 30%. You must enroll at your local ward office (区役所) within 14 days of arrival or change of status. Failure to enroll on time means you pay 100% of all medical costs during the uninsured period. Like Shakai Hoken, normal childbirth is covered by the 500,000 yen lump-sum allowance (出産育児一時金).",
    body_jp: "国民健康保険は、自営業者、パートタイム労働者、学生、3か月以上滞在する外国人のための健康保険です。医療費の70%をカバーし、自己負担は30%です。到着または在留資格変更後14日以内に区役所で加入手続きを行ってください。期限内に加入しない場合、未加入期間の医療費は全額自己負担となります。社会保険と同様、通常の出産には50万円の出産育児一時金が支給されます。",
    insurance_type: "kokumin_hoken",
    coverage_percent: 70
  },
  {
    title_en: "Travel Insurance",
    title_jp: "旅行保険",
    body_en: "Travel insurance is private insurance purchased before visiting Japan. Important: most Japanese hospitals do not accept foreign insurance directly — you pay upfront and claim reimbursement from your provider later. Always carry your insurance documents and contact your provider before visiting a hospital. Coverage varies by provider — some cover 100% of costs, others have limits. Note: Japanese hospitals and clinics generally do not accept foreign health insurance at the counter.",
    body_jp: "旅行保険は来日前に購入する民間保険です。重要：日本のほとんどの病院は外国の保険を直接受け付けていません。いったん全額を支払い、後から保険会社に払い戻し請求を行います。常に保険書類を携帯し、病院受診前に保険会社に連絡してください。保険会社によってカバー範囲が異なります。",
    insurance_type: "travel_insurance",
    coverage_percent: 100
  }
])

# =============================================================
# HOSPITALS — sourced exclusively from db/tokyo_medical_seed.json
#
# Column mapping:
#   JSON "name"        -> name_en
#   JSON "address"     -> address_en
#   JSON "contact"     -> phone
#   JSON "link"        -> website_url
#   JSON "languages"   -> insurance_notes_en  (no dedicated languages column)
#   JSON "departments" -> not stored          (no departments column; use
#                                              specialties relation if needed)
#   JSON "type"        -> not stored          (no type column)
#
# Ward logic:
#   "wards" group keys      (e.g. "Chiyoda Ward")  -> ward stored verbatim
#   "outside_23_wards" keys (e.g. "Fuchu City")    -> ward stored verbatim
#   The city-style names visually distinguish outside-23-ward entries in the UI.
#   No outside_23_wards boolean column exists in the schema.
#
# find_or_create_by(name_en:) is used as a safety net against duplicate runs;
# the block only executes on new records.
# =============================================================
puts "\nLoading hospitals from db/tokyo_medical_seed.json..."

require "json"
json_path = Rails.root.join("db", "tokyo_medical_seed.json")
json_data = JSON.parse(File.read(json_path))

ward_total    = 0
outside_total = 0

# --- 23 Special Wards ---
puts "\n  == 23 Special Wards =="
json_data["wards"].each do |ward_name, entries|
  count = 0
  entries.each do |entry|
    Hospital.find_or_create_by(name_en: entry["name"]) do |h|
      h.address_en           = entry["address"]
      h.phone                = entry["contact"]
      h.website_url          = entry["link"]
      h.ward                 = ward_name
      h.is_government        = false
      h.is_certified         = false
      h.accepts_travel_insurance = false
      # Store supported languages as a plain string (no array column exists).
      h.insurance_notes_en   = entry["languages"].presence
      h.visiting_hours       = nil
    end
    count += 1
  end
  puts "  #{ward_name.ljust(25)} #{count} entries"
  ward_total += count
end

# --- Outside 23 Wards ---
puts "\n  == Outside 23 Wards =="
json_data["outside_23_wards"].each do |city_name, entries|
  count = 0
  entries.each do |entry|
    Hospital.find_or_create_by(name_en: entry["name"]) do |h|
      h.address_en           = entry["address"]
      h.phone                = entry["contact"]
      h.website_url          = entry["link"]
      h.ward                 = city_name   # e.g. "Fuchu City", "Hachioji City"
      h.is_government        = false
      h.is_certified         = false
      h.accepts_travel_insurance = false
      h.insurance_notes_en   = entry["languages"].presence
      h.visiting_hours       = nil
    end
    count += 1
  end
  puts "  #{city_name.ljust(25)} #{count} entries"
  outside_total += count
end

# =============================================================
# SUMMARY
# =============================================================
puts ""
puts "Seed complete."
puts ""
puts "  23 special wards total:  #{ward_total}"
puts "  Outside 23 wards total:  #{outside_total}"
puts "  Grand total processed:   #{ward_total + outside_total}"
puts ""
puts "Database counts:"
puts "  #{Hospital.count} hospitals & clinics"
puts "  #{Specialty.count} specialties"
puts "  #{Service.count} services"
puts "  #{EmergencyContact.count} emergency contacts"
puts "  #{InsuranceGuide.count} insurance guides"
puts ""
puts "Source: db/tokyo_medical_seed.json"
