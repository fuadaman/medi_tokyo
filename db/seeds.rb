puts "Cleaning database..."
HospitalService.destroy_all
HospitalSpecialty.destroy_all
Hospital.destroy_all
Service.destroy_all
Specialty.destroy_all
EmergencyContact.destroy_all

puts "Creating emergency contacts..."
EmergencyContact.create!([
  {
    name_en: "Ambulance & Fire",
    name_jp: "救急・消防",
    number: "119",
    description_en: "Call for ambulance or fire emergency",
    description_jp: "救急車または火災の緊急時に電話してください"
  },
  {
    name_en: "Police",
    name_jp: "警察",
    number: "110",
    description_en: "Call for police emergency",
    description_jp: "警察の緊急時に電話してください"
  },
  {
    name_en: "Tokyo English Lifeline",
    name_jp: "東京英語いのちの電話",
    number: "03-5774-0992",
    description_en: "English counseling and emergency support",
    description_jp: "英語によるカウンセリングと緊急サポート"
  }
])

puts "Creating specialties..."
cardiology    = Specialty.create!(name_en: "Cardiology",  name_jp: "循環器科")
orthopedics   = Specialty.create!(name_en: "Orthopedics", name_jp: "整形外科")
pediatrics    = Specialty.create!(name_en: "Pediatrics",  name_jp: "小児科")
oncology      = Specialty.create!(name_en: "Oncology",    name_jp: "腫瘍科")
emergency_med = Specialty.create!(name_en: "Emergency",   name_jp: "救急科")

puts "Creating services..."
outpatient    = Service.create!(name_en: "Outpatient Care",   name_jp: "外来診療",   category: "general")
inpatient     = Service.create!(name_en: "Inpatient Care",    name_jp: "入院診療",   category: "general")
mri           = Service.create!(name_en: "MRI Scan",          name_jp: "MRI検査",    category: "diagnostic")
xray          = Service.create!(name_en: "X-Ray",             name_jp: "レントゲン", category: "diagnostic")
surgery       = Service.create!(name_en: "Surgery",           name_jp: "外科手術",   category: "surgical")
rehabilitation= Service.create!(name_en: "Rehabilitation",    name_jp: "リハビリ",   category: "recovery")

puts "Creating hospitals..."
keio = Hospital.create!(
  name_en: "Keio University Hospital",
  name_jp: "慶應義塾大学病院",
  address_en: "35 Shinanomachi, Shinjuku-ku, Tokyo",
  address_jp: "東京都新宿区信濃町35",
  phone: "03-3353-1211",
  website_url: "https://www.hosp.keio.ac.jp",
  ward: "Shinjuku-ku",
  latitude: 35.6762,
  longitude: 139.7169,
  visiting_hours: "14:00 - 20:00"
)

tokyo_medical = Hospital.create!(
  name_en: "Tokyo Medical Center",
  name_jp: "東京医療センター",
  address_en: "2-5-1 Higashigaoka, Meguro-ku, Tokyo",
  address_jp: "東京都目黒区東が丘2-5-1",
  phone: "03-3411-0111",
  website_url: "https://www.tmhp.jp",
  ward: "Meguro-ku",
  latitude: 35.6284,
  longitude: 139.6781,
  visiting_hours: "15:00 - 19:00"
)

st_lukes = Hospital.create!(
  name_en: "St. Luke's International Hospital",
  name_jp: "聖路加国際病院",
  address_en: "9-1 Akashicho, Chuo-ku, Tokyo",
  address_jp: "東京都中央区明石町9-1",
  phone: "03-3541-5151",
  website_url: "https://www.luke.ac.jp",
  ward: "Chuo-ku",
  latitude: 35.6654,
  longitude: 139.7707,
  visiting_hours: "14:00 - 20:00"
)

puts "Linking specialties..."
HospitalSpecialty.create!([
  { hospital: keio,          specialty: cardiology },
  { hospital: keio,          specialty: emergency_med },
  { hospital: tokyo_medical, specialty: oncology },
  { hospital: tokyo_medical, specialty: orthopedics },
  { hospital: st_lukes,      specialty: pediatrics },
  { hospital: st_lukes,      specialty: emergency_med }
])

puts "Linking services..."
HospitalService.create!([
  { hospital: keio,          service: outpatient },
  { hospital: keio,          service: mri },
  { hospital: keio,          service: surgery },
  { hospital: tokyo_medical, service: inpatient },
  { hospital: tokyo_medical, service: xray },
  { hospital: st_lukes,      service: outpatient },
  { hospital: st_lukes,      service: rehabilitation }
])

puts "Done! MediTokyo seed data loaded successfully."
puts "#{Hospital.count} hospitals"
puts "#{Specialty.count} specialties"
puts "#{Service.count} services"
puts "#{EmergencyContact.count} emergency contacts"
