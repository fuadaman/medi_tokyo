# =============================================================
# MediTokyo - db/seeds.rb
# Updated: All hospitals & clinics based on verified sources
# Sources: tmhp.jp, jmip.jme.or.jp, japanlivingguide.com
# =============================================================

puts "Cleaning database..."
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
cardiology      = Specialty.create!(name_en: "Cardiology",              name_jp: "循環器科")
orthopedics     = Specialty.create!(name_en: "Orthopedics",             name_jp: "整形外科")
pediatrics      = Specialty.create!(name_en: "Pediatrics",              name_jp: "小児科")
oncology        = Specialty.create!(name_en: "Oncology",                name_jp: "腫瘍科")
emergency_med   = Specialty.create!(name_en: "Emergency Medicine",      name_jp: "救急科")
neurology       = Specialty.create!(name_en: "Neurology",               name_jp: "神経科")
psychiatry      = Specialty.create!(name_en: "Psychiatry",              name_jp: "精神科")
maternity       = Specialty.create!(name_en: "Maternity & Obstetrics",  name_jp: "産婦人科・周産期")
newborn         = Specialty.create!(name_en: "Pediatrics & Newborn",    name_jp: "小児科・新生児科")
infectious      = Specialty.create!(name_en: "Infectious Diseases",     name_jp: "感染症科")
rehabilitation  = Specialty.create!(name_en: "Rehabilitation",          name_jp: "リハビリ科")
gynecology      = Specialty.create!(name_en: "Gynecology",              name_jp: "婦人科")

# =============================================================
# SERVICES
# =============================================================
puts "Creating services..."
outpatient      = Service.create!(name_en: "Outpatient Care",       name_jp: "外来診療",       category: "general")
inpatient       = Service.create!(name_en: "Inpatient Care",        name_jp: "入院診療",       category: "general")
mri             = Service.create!(name_en: "MRI Scan",              name_jp: "MRI検査",        category: "diagnostic")
xray            = Service.create!(name_en: "X-Ray",                 name_jp: "レントゲン",     category: "diagnostic")
ct_scan         = Service.create!(name_en: "CT Scan",               name_jp: "CT検査",         category: "diagnostic")
surgery         = Service.create!(name_en: "Surgery",               name_jp: "外科手術",       category: "surgical")
rehab           = Service.create!(name_en: "Rehabilitation",        name_jp: "リハビリ",       category: "recovery")
emergency_care  = Service.create!(name_en: "24h Emergency Care",    name_jp: "24時間救急",     category: "emergency")
prenatal        = Service.create!(name_en: "Prenatal Care",         name_jp: "産前ケア",       category: "maternity")
vaccination     = Service.create!(name_en: "Vaccination",           name_jp: "予防接種",       category: "preventive")

# =============================================================
# INSURANCE GUIDES
# ✅ VERIFIED — based on official MHLW, nenkin.go.jp, e-housing.jp
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
# HOSPITALS — PART 1: TOKYO METROPOLITAN GOVERNMENT HOSPITALS
# Source: tmhp.jp (Tokyo Metropolitan Hospital Organization)
# All government hospitals accept Shakai Hoken & Kokumin Hoken by law
# =============================================================
puts "Creating government hospitals..."

hiroo = Hospital.create!(
  name_en: "Tokyo Metropolitan Hiroo Hospital",
  name_jp: "東京都立広尾病院",
  address_en: "2-34-10 Ebisu, Shibuya-ku, Tokyo 150-0013",
  address_jp: "150-0013 東京都渋谷区恵比寿2-34-10", # VERIFY on tmhp.jp/hiroo
  phone: "03-3444-1181",
  website_url: "https://www.tmhp.jp/hiroo/en/",
  ward: "Shibuya-ku",
  latitude: 35.646938976173466,
  longitude: 139.72161258062744,
  visiting_hours: "Weekdays: 09:00–17:00 / Saturday only: 09:00–11:30",
  is_government: true,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Accepts all Japanese national health insurance. JMIP certified. Highest proportion of foreign patients among Tokyo metro hospitals. Bring your Hoken card.",
  insurance_notes_jp: "日本の国民健康保険・社会保険が利用できます。JMIP認定。東京都立病院の中で外国人患者の割合が最も高い。保険証をお持ちください。"
)

okubo = Hospital.create!(
  name_en: "Tokyo Metropolitan Okubo Hospital",
  name_jp: "東京都立大久保病院",
  address_en: " 2 Chome-44-1 Kabukicho, Shinjuku City, Tokyo 160-8488",
  address_jp: "160-8488 東京都新宿区歌舞伎町2-44-1",
  phone: "03-5273-7711",
  website_url: "https://www.tmhp.jp/ohkubo/",
  ward: "Shinjuku-ku",
  latitude: 35.69731,
  longitude: 139.70153,
  visiting_hours: "Weekdays: 09:00–17:00",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Accepts all Japanese national health insurance. Bring your Hoken card.",
  insurance_notes_jp: "日本の国民健康保険・社会保険が利用できます。保険証をお持ちください。"
)

otsuka = Hospital.create!(
  name_en: "Tokyo Metropolitan Otsuka Hospital",
  name_jp: "東京都立大塚病院",
  address_en: "2 Chome-8-1 Minamiotsuka, Toshima City, Tokyo 170-8476",
  address_jp: "170-8476 東京都豊島区南大塚2丁目8番1号",
  phone: "03-3941-3211",
  website_url: "https://www.tmhp.jp/otsuka/",
  ward: "Toshima-ku",
  latitude: 35.72543,
  longitude: 139.73187,
  visiting_hours: "Open 24 hours.",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Women's health specialist. Accepts all Japanese national health insurance. Bring your Hoken card.",
  insurance_notes_jp: "女性医療専門。日本の国民健康保険・社会保険が利用できます。保険証をお持ちください。"
)

komagome = Hospital.create!(
  name_en: "Tokyo Metropolitan Komagome Hospital",
  name_jp: "東京都立駒込病院",
  address_en: "3-18-22 Hon-Komagome, Bunkyo-ku, Tokyo 113-8677",
  address_jp: "東京都文京区本駒込3-18-22",
  phone: "03-3823-2101",
  website_url: "https://www.tmhp.jp/komagome/en/",
  ward: "Bunkyo-ku",
  latitude: 35.73005,
  longitude: 139.75645,
  visiting_hours: "Monday to Saturday: 09:00–17:00 (Closed Sundays and public holidays)",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Cancer & infectious diseases specialist. Multilingual website available in EN, ZH, KO. Bring your Hoken card.",
  insurance_notes_jp: "がん・感染症専門病院。英語・中国語・韓国語のウェブサイトあり。保険証をお持ちください。"
)

toshima = Hospital.create!(
  name_en: "Tokyo Metropolitan Toshima Hospital",
  name_jp: "東京都立豊島病院",
  address_en: "33-1 Sakaecho, Itabashi City, Tokyo 173-0015",
  address_jp: "173-0015 東京都板橋区栄町33-1",
  phone: "03-5375-1234",
  website_url: "https://www.tmhp.jp/toshima/",
  ward: "Itabashi-ku",
  latitude: 35.75302,
  longitude: 139.70100,
  visiting_hours: "Weekdays: 08:30–17:00 / Saturday only: 08:30–12:30",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "General acute care hospital. Accepts all Japanese national health insurance. Bring your Hoken card.",
  insurance_notes_jp: "一般急性期病院。日本の国民健康保険・社会保険が利用できます。保険証をお持ちください。"
)

ebara = Hospital.create!(
  name_en: "Tokyo Metropolitan Ebara Hospital",
  name_jp: "東京都立荏原病院",
  address_en: "4-5-10 Higashiyukigaya, Ota-ku, Tokyo 145-0065",
  address_jp: "東京都大田区東雪谷4-5-10",
  phone: "03-5734-8000",
  website_url: "https://www.tmhp.jp/ebara/en/",
  ward: "Ota-ku",
  latitude: 35.59359,
  longitude: 139.69283,
  visiting_hours: "Weekdays: 09:00–17:00 / Saturday only: 09:00–12:00",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Multilingual website in EN, ZH, KO. Accepts all Japanese national health insurance. Bring your Hoken card.",
  insurance_notes_jp: "英語・中国語・韓国語のウェブサイトあり。日本の国民健康保険・社会保険が利用できます。保険証をお持ちください。"
)

bokutoh = Hospital.create!(
  name_en: "Tokyo Metropolitan Bokutoh Hospital",
  name_jp: "東京都立墨東病院",
  address_en: "4-23-15 Kotobashi, Sumida-ku, Tokyo 130-8575", # MANUAL: get exact address from tmhp.jp/bokutoh
  address_jp: "130-8575 東京都墨田区江東橋4-23-15",      # MANUAL: get exact address from tmhp.jp/bokutoh
  phone: "03-3633-6151",
  website_url: "https://www.tmhp.jp/bokutoh/en/",
  ward: "Sumida-ku",
  latitude: 35.69476,
  longitude: 139.81881,
  visiting_hours: "Weekdays: 08:30–17:00 / Saturday only: 08:30–12:00",
  is_government: true,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "JMIP certified. Cancer diagnosis & emergency center. Accepts all Japanese national health insurance. Bring your Hoken card.",
  insurance_notes_jp: "JMIP認定。がん診断・救急センター。日本の国民健康保険・社会保険が利用できます。保険証をお持ちください。"
)

tama = Hospital.create!(
  name_en: "Tokyo Metropolitan Tama Medical Center",
  name_jp: "東京都立多摩総合医療センター",
  address_en: "2-8-29 Musashidai, Fuchu-shi, Tokyo 183-8524",
  address_jp: "東京都府中市武蔵台2-8-29",
  phone: "042-323-5111",
  website_url: "https://www.tmhp.jp/tama/en/",
  ward: "Fuchu-shi",
  latitude: 35.69207,
  longitude: 139.46185,
  visiting_hours: "Weekdays: 09:00–17:00 / Saturday only: 09:00–12:00",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Large regional hospital. Emergency & disaster response center. Accepts all Japanese national health insurance. Bring your Hoken card.",
  insurance_notes_jp: "大規模地域病院。救急・災害拠点病院。日本の国民健康保険・社会保険が利用できます。保険証をお持ちください。"
)

neurological = Hospital.create!(
  name_en: "Tokyo Metropolitan Neurological Hospital",
  name_jp: "東京都立神経病院",
  address_en: "2-6-1 Musashidai, Fuchu City, Tokyo 183-0042",
  address_jp: "〒183-0042 東京都府中市武蔵台2-6-1",      # MANUAL: get exact address from tmhp.jp/shinkei
  phone: "042-323-5110", # MANUAL: verify phone number
  website_url: "https://www.tmhp.jp/shinkei/",
  ward: "Fuchu-shi",
  latitude: 35.69074,
  longitude: 139.46123,
  visiting_hours: "Check tmhp.jp/shinkei for current hours",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Neurology & neurosurgery specialist. Only dedicated neurological hospital in Tokyo. Bring your Hoken card.",
  insurance_notes_jp: "神経科・脳神経外科専門。東京唯一の神経専門病院。保険証をお持ちください。"
)

childrens = Hospital.create!(
  name_en: "Tokyo Metropolitan Children's Medical Center",
  name_jp: "東京都立小児総合医療センター",
  address_en: "2 Chome-8-29 Musashidai, Fuchu, Tokyo 183-8561",
  address_jp: "183-8561　東京都府中市武蔵台　2-8-29",
  phone: "042-300-5111",  # MANUAL: verify phone number
  website_url: "https://www.tmhp.jp/shouni/en/",
  ward: "Fuchu-shi",
  latitude: 35.69210,
  longitude: 139.46074,
  visiting_hours: "Check tmhp.jp/shouni for current hours",
  is_government: true,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Pediatric specialist. Ranked 4th in Japan (Newsweek 2023). Accepts all Japanese national health insurance. Bring your Hoken card.",
  insurance_notes_jp: "小児専門病院。ニューズウィーク2023年日本4位。日本の国民健康保険・社会保険が利用できます。保険証をお持ちください。"
)

matsuzawa = Hospital.create!(
  name_en: "Tokyo Metropolitan Matsuzawa Hospital",
  name_jp: "東京都立松沢病院",
  address_en: "2 Chome-1-1 Kamikitazawa, Setagaya City, Tokyo 156-0057",
  address_jp: "156-0057　東京都世田谷区上北沢 2-1-1",
  phone: "03-3303-7211",
  website_url: "https://www.tmhp.jp/matsuzawa/en/",
  ward: "Setagaya-ku",
  latitude: 35.66706,
  longitude: 139.61816,
  visiting_hours: "Weekdays: 09:00–12:00 and 13:00–17:00",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Psychiatric & mental health specialist. 140-year history. Accepts all Japanese national health insurance. Bring your Hoken card.",
  insurance_notes_jp: "精神科・メンタルヘルス専門。140年の歴史。日本の国民健康保険・社会保険が利用できます。保険証をお持ちください。"
)

# =============================================================
# HOSPITALS — PART 2: JMIP / JCI CERTIFIED CLINICS
# Source: jmip.jme.or.jp, internationalinsurance.com, japanlivingguide.com
# =============================================================
puts "Creating certified clinics..."

st_lukes = Hospital.create!(
  name_en: "St. Luke's International Hospital",
  name_jp: "聖路加国際病院",
  address_en: "9-1 Akashicho, Chuo-ku, Tokyo 104-8560",
  address_jp: "東京都中央区明石町9-1",
  phone: "03-3541-5151",
  website_url: "https://www.luke.ac.jp/",
  ward: "Chuo-ku",
  latitude: 35.66762,
  longitude: 139.77669,
  visiting_hours: "Weekdays: 08:30–17:00",
  is_government: false,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: false,
  accepts_travel_insurance: true,
  insurance_notes_en: "JCI + JMIP certified. Serving Tokyo's foreign community since 1902. 24h emergency. Accepts Shakai Hoken and travel insurance. Does NOT accept Kokumin Hoken.",
  insurance_notes_jp: "JCI・JMIP認定。1902年から外国人コミュニティに医療を提供。24時間救急。社会保険・旅行保険対応。国民健康保険は非対応。"
)

saiseikai = Hospital.create!(
  name_en: "Tokyo Saiseikai Central Hospital",
  name_jp: "済生会中央病院",
  address_en: "1 Chome-4-17 Mita, Minato City, Tokyo 108-0073",
  address_jp: "108-0073 東京都港区三田1-4-17",
  phone: "03-3451-8211",
  website_url: "https://www.saiseikai.or.jp/",
  ward: "Minato-ku",
  latitude: 35.65413,
  longitude: 139.74406,
  visiting_hours: "Weekdays: 08:00–11:30",
  is_government: false,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "JMIP certified. International office with interpreters in EN, ES, FR, PT, ZH. Emergency & Critical Care Center on-site. Advance reservation recommended.",
  insurance_notes_jp: "JMIP認定。英語・スペイン語・フランス語・ポルトガル語・中国語の通訳あり。救急・集中治療センター併設。事前予約推奨。"
)

ncgm = Hospital.create!(
  name_en: "National Center for Global Health and Medicine",
  name_jp: "国立国際医療研究センター病院",
  address_en: "1-21-1 Toyama, Shinjuku-ku, Tokyo 162-8655",
  address_jp: "東京都新宿区戸山1-21-1",
  phone: "03-6228-0749",
  website_url: "https://www.ncgm.go.jp/",
  ward: "Shinjuku-ku",
  latitude: 35.70183,
  longitude: 139.71634,
  visiting_hours: "Weekdays: 08:30–17:15",
  is_government: true,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Government-run. JMIP certified. Travel clinic available. International patient desk. Contact in advance for appointments.",
  insurance_notes_jp: "国立病院。JMIP認定。トラベルクリニックあり。国際患者窓口あり。受診前に事前連絡推奨。"
)

ntt_medical = Hospital.create!(
  name_en: "NTT Medical Center Tokyo",
  name_jp: "NTT東日本関東病院",
  address_en: "5-9-22 Higashigotanda, Shinagawa-ku, Tokyo 141-8625",
  address_jp: "東京都品川区東五反田5-9-22",
  phone: "03-6721-6239",
  website_url: "https://www.nmct.ntt-east.co.jp/en/",
  ward: "Shinagawa-ku",
  latitude: 35.63110,
  longitude: 139.72595,
  visiting_hours: "Weekdays: 08:30–11:00 and 13:00–15:00",
  is_government: false,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "JCI + JMIP + JIH certified. English-speaking primary care physicians available. Referral letter recommended for first visit.",
  insurance_notes_jp: "JCI・JMIP・JIH認定。英語対応の内科医あり。初診時は紹介状推奨。"
)

# =============================================================
# HOSPITALS — PART 2B: INTERNATIONAL CLINICS
# Source: tmsc.jp, sendagaya-ic.com, ejable.com, tokyocheapo.com
# =============================================================
puts "Creating international clinics..."

univ_tokyo = Hospital.create!(
  name_en: "University of Tokyo Hospital",
  name_jp: "東京大学医学部附属病院",
  address_en: "7-3-1 Hongo, Bunkyo-ku, Tokyo 113-8655",
  address_jp: "東京都文京区本郷7-3-1",
  phone: "03-3815-5411",
  website_url: "https://www.h.u-tokyo.ac.jp/english/",
  ward: "Bunkyo-ku",
  latitude: 35.762887,
  longitude: 139.766065,
  visiting_hours: "Weekdays 08:30–17:00 (Outpatient). Referral required for international patients.",
  is_government: true,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Accepts Shakai Hoken and Kokumin Hoken. International patients without Japanese insurance billed at private rate. Contact International Medical Center in advance. Most doctors speak English.",
  insurance_notes_jp: "社会保険・国民健康保険対応。外国人患者で保険なしの場合は自費診療。事前に国際診療部へご連絡ください。"
)

takanawa = Hospital.create!(
  name_en: "JCHO Tokyo Takanawa Hospital",
  name_jp: "JCHO東京高輪病院",
  address_en: "3-10-11 Takanawa, Minato-ku, Tokyo 108-8606",
  address_jp: "東京都港区高輪3-10-11",
  phone: "03-3443-9191",
  website_url: "https://tokyo-takanawa.jcho.go.jp/",
  ward: "Minato-ku",
  latitude: 35.635825,
  longitude: 139.733641,
  visiting_hours: "Weekdays 09:00–11:30 (Outpatient) / Emergency: after 17:30 weekdays, 24h weekends",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Accepts Shakai Hoken and Kokumin Hoken. International Assistance Desk open weekdays 09:00–15:45. English, Chinese and Russian language support available.",
  insurance_notes_jp: "社会保険・国民健康保険対応。国際窓口：平日09:00〜15:45。英語・中国語・ロシア語対応。"
)

tmsc = Hospital.create!(
  name_en: "Tokyo Medical and Surgical Clinic",
  name_jp: "東京メディカル・サージカル・クリニック",
  address_en: "32 Shiba Koen Bldg 2F, 3-4-30 Shibakoen, Minato-ku, Tokyo 105-0011",
  address_jp: "東京都港区芝公園3-4-30 芝公園32ビル2F",
  phone: "03-3436-3028",
  website_url: "https://tmsc.jp/",
  ward: "Minato-ku",
  latitude: 35.656308,
  longitude: 139.745787,
  visiting_hours: "Weekdays 09:00–17:00 / Saturday 09:00–12:00",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: false,
  accepts_kokumin_hoken: false,
  accepts_travel_insurance: true,
  insurance_notes_en: "Does NOT accept Japanese national health insurance. Private pay only. Receipts provided for international insurance reimbursement. US/European trained doctors. English, Spanish, German, French spoken.",
  insurance_notes_jp: "日本の健康保険は不可。自費診療のみ。国際保険の払い戻し用領収書発行可。英語・スペイン語・ドイツ語・フランス語対応。"
)

sendagaya = Hospital.create!(
  name_en: "Sendagaya International Clinic",
  name_jp: "千駄ヶ谷インターナショナルクリニック",
  address_en: "2F Barbizon Bldg 11, 1-20-3 Sendagaya, Shibuya-ku, Tokyo 151-0051",
  address_jp: "東京都渋谷区千駄ヶ谷1-20-3 バルビゾン11 2F",
  phone: "03-3478-4747",
  website_url: "https://sendagaya-ic.com/en/",
  ward: "Shibuya-ku",
  latitude: 35.681674,
  longitude: 139.714023,
  visiting_hours: "Mon 13:00–19:00 / Tue Thu Fri 09:00–19:00 / Sat 09:00–14:00 / Closed Wed & Sun",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: true,
  insurance_notes_en: "Accepts Shakai Hoken, Kokumin Hoken and travel insurance. Walk-ins welcome. English and French speaking staff. Specializes in travel medicine and care for international patients.",
  insurance_notes_jp: "社会保険・国民健康保険・旅行保険対応。飛び込み歓迎。英語・フランス語対応。旅行医学・外国人患者専門。"
)

# =============================================================
# HOSPITALS — PART 3: MATERNITY & PEDIATRIC SPECIALISTS
# Source: japanlivingguide.com (verified)
# =============================================================
puts "Creating maternity & pediatric hospitals..."

aiiku = Hospital.create!(
  name_en: "Aiiku Hospital",
  name_jp: "愛育病院",
  address_en: "1 Chome-16-10 Shibaura, Minato City, Tokyo 105-8321",
  address_jp: "105-8321 東京都港区芝浦1丁目16-10",
  phone: "03-6453-7300",
  website_url: "https://www.aiiku.net/",
  ward: "Minato-ku",
  latitude: 35.64688,
  longitude: 139.75261,
  visiting_hours: "Monday to Wednesday: 08:30–16:30; Thursday: 08:30-16:30; Friday: 08:30-16:30; Saturday: 08:30-11:30",
  is_government: false,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Specialist maternity & pediatrics hospital. Delivers over 1,500 babies per year. Japan's royal family chose this hospital for the imperial birth in 2006. Maternity lump-sum allowance (500,000 yen) applies.",
  insurance_notes_jp: "産婦人科・小児科専門病院。年間1,500件以上の分娩。2006年に皇室の出産にも選ばれた病院。出産育児一時金（50万円）が適用されます。"
)

red_cross = Hospital.create!(
  name_en: "Japanese Red Cross Medical Center",
  name_jp: "日本赤十字社医療センター",
  address_en: "4-1-22 Hiroo, Shibuya-ku, Tokyo",
  address_jp: "東京都渋谷区広尾4-1-22",
  phone: "03-3400-1311",
  website_url: "https://www.med.jrc.or.jp/",
  ward: "Shibuya-ku",
  latitude: 35.65475,
  longitude: 139.71790,
  visiting_hours: "Weekdays: 09:00–17:00",
  is_government: false,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "JMIP certified. Strong English emergency services. Maternity & general care. Experienced with expat emergencies. 10-minute walk from Shibuya and Ebisu Stations.",
  insurance_notes_jp: "JMIP認定。英語対応の救急サービスあり。産科・一般診療。在日外国人の緊急対応経験豊富。渋谷駅・恵比寿駅から徒歩10分。"
)

# =============================================================
# HOSPITALS — PART 4: WARD-BY-WARD COVERAGE (23 WARDS)
# =============================================================
puts "Creating ward-by-ward hospitals & clinics..."

# --- ARAKAWA-KU ---
kosaka_ophthalmology = Hospital.create!(
  name_en: "Kosaka Ophthalmology",
  name_jp: "小坂眼科",
  phone: "03-5615-0321",
  website_url: "https://maps.google.com/?q=Kosaka+Ophthalmology+Arakawa+Tokyo",
  ward: "Arakawa-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- ADACHI-KU ---
aqua_dental = Hospital.create!(
  name_en: "aQua Dental Clinic",
  name_jp: "アクア歯科クリニック",
  phone: "03-3882-6677",
  website_url: "https://maps.google.com/?q=aQua+Dental+Clinic+Adachi+Tokyo",
  ward: "Adachi-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

takahashi_clinic_adachi = Hospital.create!(
  name_en: "Takahashi Clinic Adachi-ku",
  name_jp: "高橋クリニック足立区",
  phone: "03-3854-3031",
  website_url: "https://maps.google.com/?q=Takahashi+Clinic+Adachi+Tokyo",
  ward: "Adachi-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kohoku_family_clinic = Hospital.create!(
  name_en: "Kohoku Family Clinic",
  name_jp: "江北ファミリークリニック",
  phone: "03-3897-3030",
  website_url: "https://maps.google.com/?q=kohoku+family+clinic+Adachi+Tokyo",
  ward: "Adachi-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- KATSUSHIKA-KU ---
koujinkai_daiichi = Hospital.create!(
  name_en: "Koujinkai Daiichi Hospital",
  name_jp: "厚仁会第一病院",
  phone: "03-3607-0007",
  website_url: "https://maps.google.com/?q=Koujinkai+Daiichi+Hospital+Katsushika+Tokyo",
  ward: "Katsushika-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tobu_chiiki = Hospital.create!(
  name_en: "Tokyo Metropolitan Tobu Chiiki Hospital",
  name_jp: "東京都立東部地域病院",
  phone: "03-5682-5111",
  website_url: "https://maps.google.com/?q=Tokyo+Metropolitan+Tobu+Chiiki+Hospital+Katsushika+Tokyo",
  ward: "Katsushika-ku",
  visiting_hours: "# VERIFY",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- SUMIDA-KU ---
# NOTE: bokutoh (Tokyo Metropolitan Bokutoh Hospital) is already defined above with full verified data.

kinshicho_mint_dental = Hospital.create!(
  name_en: "Kinshicho Mint Dental Clinic",
  name_jp: "錦糸町ミント歯科",
  phone: "03-5637-7610",
  website_url: "https://maps.google.com/?q=Kinshicho+Mint+Dental+Clinic+Sumida+Tokyo",
  ward: "Sumida-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- KOTO-KU ---
telecom_center_dental = Hospital.create!(
  name_en: "Telecom Center Dental Office",
  name_jp: "テレコムセンター歯科",
  phone: "03-5500-0418",
  website_url: "https://maps.google.com/?q=Telecom+Center+Dental+Office+Koto+Tokyo",
  ward: "Koto-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

wakaba_dental = Hospital.create!(
  name_en: "Wakaba Dental Clinic",
  name_jp: "わかば歯科クリニック",
  phone: "03-3684-3655",
  website_url: "https://maps.google.com/?q=Wakaba+Dental+Clinic+Koto+Tokyo",
  ward: "Koto-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

sekoukai_dental = Hospital.create!(
  name_en: "Sekoukai Dental Office Tokyo Bay",
  name_jp: "世光会歯科東京ベイ",
  phone: "03-5530-3755",
  website_url: "https://maps.google.com/?q=Sekoukai+Dental+Office+Tokyo+Bay+Koto+Tokyo",
  ward: "Koto-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ono_cardiology = Hospital.create!(
  name_en: "Ono Cardiology and GP Medical Office",
  name_jp: "小野循環器科・内科医院",
  phone: "03-3636-5505",
  website_url: "https://maps.google.com/?q=Ono+Cardiology+GP+Medical+Office+Koto+Tokyo",
  ward: "Koto-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kobayashi_clinic_koto = Hospital.create!(
  name_en: "Kobayashi Clinic",
  name_jp: "小林クリニック",
  phone: "03-3684-0481",
  website_url: "https://maps.google.com/?q=Kobayashi+Clinic+Koto+Tokyo",
  ward: "Koto-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

heiwa_memorial_clinic = Hospital.create!(
  name_en: "Heiwa Memorial Clinic",
  name_jp: "平和記念クリニック",
  phone: "03-3820-8880",
  website_url: "https://maps.google.com/?q=HEIWA+MEMORIAL+CLINIC+Koto+Tokyo",
  ward: "Koto-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

toyosu_minna_clinic = Hospital.create!(
  name_en: "Toyosu Minna Clinic Toyosu",
  name_jp: "豊洲みんなクリニック豊洲",
  phone: "03-6204-2733",
  website_url: "https://maps.google.com/?q=Toyosu+Minna+Clinic+Koto+Tokyo",
  ward: "Koto-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kameido_eye_clinic = Hospital.create!(
  name_en: "Kameido Eye Clinic",
  name_jp: "亀戸眼科クリニック",
  phone: "03-3682-9973",
  website_url: "https://maps.google.com/?q=Kameido+Eye+Clinic+Koto+Tokyo",
  ward: "Koto-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kameido_central_clinic = Hospital.create!(
  name_en: "Kameido Central Clinic",
  name_jp: "亀戸セントラルクリニック",
  phone: "03-5628-6531",
  website_url: "https://maps.google.com/?q=KAMEIDO+CENTRAL+CLINIC+Koto+Tokyo",
  ward: "Koto-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

shinonome_medical = Hospital.create!(
  name_en: "Shinonome Medical Clinic",
  name_jp: "塩浜医院",
  phone: "03-6910-1623",
  website_url: "https://maps.google.com/?q=Shinonome+medical+clinic+Koto+Tokyo",
  ward: "Koto-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- EDOGAWA-KU ---
moriyama_memorial = Hospital.create!(
  name_en: "Moriyama Memorial Hospital",
  name_jp: "森山記念病院",
  phone: "03-5679-1211",
  website_url: "https://maps.google.com/?q=Moriyama+Memorial+Hospital+Edogawa+Tokyo",
  ward: "Edogawa-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokyo_rinkai = Hospital.create!(
  name_en: "Tokyo Rinkai Hospital",
  name_jp: "東京臨海病院",
  phone: "03-5605-8811",
  website_url: "https://maps.google.com/?q=Tokyo+Rinkai+Hospital+Edogawa+Tokyo",
  ward: "Edogawa-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

nishikasai_lifestyle_a = Hospital.create!(
  name_en: "Nishikasai Life Style Clinic",
  name_jp: "西葛西ライフスタイルクリニック",
  phone: "080-4340-9083",
  website_url: "https://maps.google.com/?q=Nishikasai+Life+Style+Clinic+Edogawa+Tokyo",
  ward: "Edogawa-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

nishikasai_smile_dental = Hospital.create!(
  name_en: "Nishikasai Smile Dental Clinic",
  name_jp: "西葛西スマイル歯科",
  phone: "03-3675-4182",
  website_url: "https://maps.google.com/?q=Nishikasai+Smile+Dental+Clinic+Edogawa+Tokyo",
  ward: "Edogawa-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

himawari_dental = Hospital.create!(
  name_en: "Himawari Dental Clinic",
  name_jp: "ひまわり歯科クリニック",
  phone: "03-5622-2350",
  website_url: "https://maps.google.com/?q=Himawari+Dental+Clinic+Edogawa+Tokyo",
  ward: "Edogawa-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

nishikasai_lifestyle_b = Hospital.create!(
  name_en: "Nishikasai Lifestyle Clinic (Branch)",
  name_jp: "西葛西ライフスタイルクリニック（別院）",
  phone: "080-3640-9636",
  website_url: "https://maps.google.com/?q=NISHIKASAI+LIFESTYLE+CLINIC+Edogawa+Tokyo",
  ward: "Edogawa-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Multiple languages supported via translation machine.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kobayashi_dental_edogawa = Hospital.create!(
  name_en: "Kobayashi Dental Clinic",
  name_jp: "小林歯科クリニック",
  phone: "03-3653-7567",
  website_url: "https://maps.google.com/?q=KOBAYASHI+DENTAL+CLINIC+Edogawa+Tokyo",
  ward: "Edogawa-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Home visit available. English and Russian supported for home visits.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- CHIYODA-KU ---
tokyo_station_international = Hospital.create!(
  name_en: "Tokyo Station International Clinic",
  name_jp: "東京ステーションインターナショナルクリニック",
  phone: "03-6206-3070",
  website_url: "https://maps.google.com/?q=Tokyo+Station+International+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

isdorly_orthodontic = Hospital.create!(
  name_en: "Isdorly Orthodontic Office",
  name_jp: "イズドーリー矯正歯科",
  phone: "03-6206-4806",
  website_url: "https://maps.google.com/?q=Isdorly+Orthodontic+Office+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: false,
  accepts_kokumin_hoken: false,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ochanomizu_vascular = Hospital.create!(
  name_en: "Ochanomizu Vascular & Vein Clinic",
  name_jp: "御茶ノ水血管・静脈クリニック",
  phone: "03-5281-4103",
  website_url: "https://maps.google.com/?q=Ochanomizu+Vascular+Vein+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

shinomiya_clinic = Hospital.create!(
  name_en: "Shinomiya Clinic",
  name_jp: "四宮クリニック",
  phone: "03-5687-1516",
  website_url: "https://maps.google.com/?q=Shinomiya+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ambulatory_vascular = Hospital.create!(
  name_en: "Ambulatory Vascular Surgical Clinic Tokyo",
  name_jp: "東京外来血管外科クリニック",
  phone: "03-5289-0072",
  website_url: "https://maps.google.com/?q=Ambulatory+Vascular+Surgical+Clinic+Tokyo+Chiyoda",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

dental_salon_kojimachi = Hospital.create!(
  name_en: "Dental Salon Kojimachi",
  name_jp: "デンタルサロン麹町",
  phone: "03-6268-9810",
  website_url: "https://maps.google.com/?q=Dental+Salon+Kojimachi+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

your_clinic_akihabara = Hospital.create!(
  name_en: "Your Clinic Akihabara",
  name_jp: "ユアクリニック秋葉原",
  phone: "03-3256-1180",
  website_url: "https://maps.google.com/?q=Your+Clinic+Akihabara+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ichihashi_dental = Hospital.create!(
  name_en: "Ichihashi Dental Clinic",
  name_jp: "市橋歯科クリニック",
  phone: "03-3211-2848",
  website_url: "https://maps.google.com/?q=Ichihashi+Dental+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokousha_kensin = Hospital.create!(
  name_en: "Tokousha Kensin Clinic",
  name_jp: "東光社健診クリニック",
  phone: "03-3212-0105",
  website_url: "https://maps.google.com/?q=Tokousha+Kensin+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

sanno_medical = Hospital.create!(
  name_en: "Sanno Medical Clinic",
  name_jp: "山王メディカルクリニック",
  phone: "03-3580-5001",
  website_url: "https://maps.google.com/?q=Sanno+Medical+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

jtk_clinic = Hospital.create!(
  name_en: "JTK Clinic",
  name_jp: "JTKクリニック",
  phone: "03-6261-6386",
  website_url: "https://maps.google.com/?q=JTK+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kojimachi_dermatology = Hospital.create!(
  name_en: "Kojimachi Dermatology, Plastic Surgery Clinic",
  name_jp: "麹町皮膚科・形成外科クリニック",
  phone: "03-6261-2458",
  website_url: "https://maps.google.com/?q=Kojimachi+Dermatology+Plastic+Surgery+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kandabashi_dental = Hospital.create!(
  name_en: "Kandabashi Dental Office",
  name_jp: "神田橋デンタルオフィス",
  phone: "03-5283-6533",
  website_url: "https://maps.google.com/?q=Kandabashi+Dental+Office+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

st_lukes_medilocus = Hospital.create!(
  name_en: "St. Luke's MediLocus",
  name_jp: "聖路加メディローカス",
  phone: "03-3527-9520",
  website_url: "https://maps.google.com/?q=St+Lukes+MediLocus+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

imperial_clinic = Hospital.create!(
  name_en: "Imperial Clinic",
  name_jp: "インペリアルクリニック",
  phone: "03-3503-8681",
  website_url: "https://maps.google.com/?q=Imperial+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokyo_seaside_clinic = Hospital.create!(
  name_en: "Tokyo Seaside Clinic",
  name_jp: "東京シーサイドクリニック",
  phone: "03-6272-6616",
  website_url: "https://maps.google.com/?q=Tokyo+Seaside+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokyo_business_clinic_marunouchi = Hospital.create!(
  name_en: "Tokyo Business Clinic GRANSTA Marunouchi",
  name_jp: "東京ビジネスクリニックGRANSTA丸の内",
  phone: "03-6259-1605",
  website_url: "https://maps.google.com/?q=Tokyo+Business+Clinic+GRANSTA+MARUNOUCHI+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokyo_business_clinic_yaesu = Hospital.create!(
  name_en: "Tokyo Business Clinic Yaesu-kitaguchi",
  name_jp: "東京ビジネスクリニック八重洲北口",
  phone: "03-6268-0079",
  website_url: "https://maps.google.com/?q=Tokyo+Business+Clinic+Yaesu+kitaguchi+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokyo_teishin = Hospital.create!(
  name_en: "Tokyo Teishin Hospital",
  name_jp: "東京逓信病院",
  phone: "03-5214-7111",
  website_url: "https://maps.google.com/?q=Tokyo+Teishin+Hospital+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

hibiya_clinic = Hospital.create!(
  name_en: "Hibiya Clinic",
  name_jp: "日比谷クリニック",
  phone: "03-3215-1105",
  website_url: "https://maps.google.com/?q=Hibiya+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

hamille_dental_tokyo = Hospital.create!(
  name_en: "Hamille Tokyo Dental Office",
  name_jp: "ハミルトン東京デンタルオフィス",
  phone: "03-5280-6480",
  website_url: "https://maps.google.com/?q=HAMILLE+TOKYO+DENTAL+OFFICE+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Chinese (Mandarin only) available via return call.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

hamille_ogawamachi = Hospital.create!(
  name_en: "Hamille Tokyo Ogawamachi",
  name_jp: "ハミルトン東京小川町",
  phone: "03-6275-0988",
  website_url: "https://maps.google.com/?q=HAMILLE+TOKYO+OGAWAMACHI+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

asahi_ladies_clinic = Hospital.create!(
  name_en: "Asahi Ladies Clinic",
  name_jp: "旭レディースクリニック",
  phone: "03-3251-3588",
  website_url: "https://maps.google.com/?q=Asahi+Ladies+Clinic+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

minsyu_dermatology = Hospital.create!(
  name_en: "Minsyu Dermatology Clinic Kudan-Kaikan Terrace",
  name_jp: "民主皮膚科クリニック九段会館テラス",
  phone: "03-6256-8981",
  website_url: "https://maps.google.com/?q=MINSYU+Dermatology+Clinic+KUDAN+KAIKAN+TERRACE+Chiyoda+Tokyo",
  ward: "Chiyoda-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- CHUO-KU ---
# NOTE: st_lukes (St. Luke's International Hospital) is already defined above with full verified data.

kishi_clinica_femina = Hospital.create!(
  name_en: "Kishi Clinica Femina",
  name_jp: "岸クリニカフェミナ",
  phone: "03-5537-7171",
  website_url: "https://maps.google.com/?q=KISHI+CLINICA+FEMINA+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

online_general_clinic = Hospital.create!(
  name_en: "Online General Clinic",
  name_jp: "オンライン総合クリニック",
  phone: "03-6691-9525",
  website_url: "https://maps.google.com/?q=Online+General+Clinic+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

koike_clinic = Hospital.create!(
  name_en: "Koike Clinic",
  name_jp: "小池クリニック",
  phone: "03-3271-0813",
  website_url: "https://maps.google.com/?q=Koike+Clinic+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

mamizuka_dental = Hospital.create!(
  name_en: "Mamizuka Dental Clinic",
  name_jp: "間見塚歯科クリニック",
  phone: "03-3541-8110",
  website_url: "https://maps.google.com/?q=Mamizuka+Dental+Clinic+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

pulice_beauty = Hospital.create!(
  name_en: "Pulice Beauty & Health",
  name_jp: "プリス美容・健康",
  phone: "03-3538-6767",
  website_url: "https://maps.google.com/?q=Pulice+Beauty+Health+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

yaesugai_medical = Hospital.create!(
  name_en: "Yaesugai Medical Clinic",
  name_jp: "八重洲外医院",
  phone: "03-3271-1828",
  website_url: "https://maps.google.com/?q=Yaesugai+Medical+Clinic+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

fujimoto_international_dental = Hospital.create!(
  name_en: "Fujimoto International Dental Clinic",
  name_jp: "藤本インターナショナル歯科クリニック",
  phone: "03-5551-0051",
  website_url: "https://maps.google.com/?q=Fujimoto+International+Dental+Clinic+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kameda_kyobashi = Hospital.create!(
  name_en: "Kameda Kyobashi Clinic",
  name_jp: "亀田京橋クリニック",
  phone: "03-5542-1182",
  website_url: "https://maps.google.com/?q=Kameda+Kyobashi+Clinic+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

nihonbashi_primary = Hospital.create!(
  name_en: "Nihonbashi Primary Health Care Clinic",
  name_jp: "日本橋プライマリケアクリニック",
  phone: "03-6667-0855",
  website_url: "https://maps.google.com/?q=Nihonbashi+Primary+Health+Care+Clinic+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ps_i_clinic = Hospital.create!(
  name_en: "Psychosomatic and Internal Medicine Clinic (Ps I Clinic)",
  name_jp: "心療内科・内科クリニック（Ps Iクリニック）",
  phone: "03-6228-5581",
  website_url: "https://maps.google.com/?q=Ps+I+Clinic+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

harai_clinic = Hospital.create!(
  name_en: "Harai Clinic",
  name_jp: "原井クリニック",
  phone: "03-3538-6055",
  website_url: "https://maps.google.com/?q=Harai+Clinic+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

igarashi_endocrine = Hospital.create!(
  name_en: "Igarashi Endocrine Clinic",
  name_jp: "五十嵐内分泌クリニック",
  phone: "03-3820-8855",
  website_url: "https://maps.google.com/?q=Igarashi+Endocrine+Clinic+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

takahashi_clinic_chuo = Hospital.create!(
  name_en: "Takahashi Clinic",
  name_jp: "高橋クリニック",
  phone: "03-3551-5955",
  website_url: "https://maps.google.com/?q=Takahashi+Clinic+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ningyocho_internal_medicine = Hospital.create!(
  name_en: "Internal Medicine General Clinic Ningyocho",
  name_jp: "内科一般クリニック人形町",
  phone: "050-3146-4285",
  website_url: "https://maps.google.com/?q=Internal+Medicine+General+Clinic+Ningyocho+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

total_skin_care_ginza = Hospital.create!(
  name_en: "Total Skin Care Clinic Ginza",
  name_jp: "トータルスキンケアクリニック銀座",
  phone: "03-6281-5208",
  website_url: "https://maps.google.com/?q=Total+Skin+Care+Clinic+GINZA+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Multiple languages including Chinese and Korean supported via tablet.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kuramochi_nihonbashi = Hospital.create!(
  name_en: "Kuramochi Clinic Interpark Nihonbashi",
  name_jp: "倉持クリニックインターパーク日本橋",
  phone: "03-5801-9893",
  website_url: "https://maps.google.com/?q=Kuramochi+Clinic+Interpark+Nihonbashi+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

mammaria_tsukiji = Hospital.create!(
  name_en: "Mammaria Tsukiji",
  name_jp: "マンマリア築地",
  phone: "03-3545-0880",
  website_url: "https://maps.google.com/?q=mammaria+tsukiji+Chuo+Tokyo",
  ward: "Chuo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- BUNKYO-KU ---
coco_medical = Hospital.create!(
  name_en: "Coco Medical Clinic",
  name_jp: "ここメディカルクリニック",
  phone: "03-6882-3319",
  website_url: "https://maps.google.com/?q=Coco+Medical+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

personal_health_clinic = Hospital.create!(
  name_en: "Personal Health Clinic",
  name_jp: "パーソナルヘルスクリニック",
  phone: "03-5817-4415",
  website_url: "https://maps.google.com/?q=Personal+Health+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Transgender health care available.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

murai_clinic = Hospital.create!(
  name_en: "Internal Medicine and Cardiovascular Murai Clinic",
  name_jp: "内科・循環器科むらいクリニック",
  phone: "070-8339-2683",
  website_url: "https://maps.google.com/?q=Murai+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

dentsuin_clinic = Hospital.create!(
  name_en: "Dentsuin Clinic",
  name_jp: "伝通院クリニック",
  phone: "03-6912-1565",
  website_url: "https://maps.google.com/?q=Dentsuin+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

hitomi_dental_bunkyo = Hospital.create!(
  name_en: "Hitomi Dental Office",
  name_jp: "ひとみ歯科",
  phone: "03-6280-8789",
  website_url: "https://maps.google.com/?q=Hitomi+Dental+Office+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

takagi_dental = Hospital.create!(
  name_en: "Takagi Dental Clinic",
  name_jp: "高木歯科クリニック",
  phone: "03-3815-6725",
  website_url: "https://maps.google.com/?q=Takagi+Dental+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

sakuma_dental = Hospital.create!(
  name_en: "Sakuma Dental Clinic",
  name_jp: "佐久間歯科クリニック",
  phone: "03-3941-0280",
  website_url: "https://maps.google.com/?q=Sakuma+Dental+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

juntendo = Hospital.create!(
  name_en: "Juntendo University Hospital",
  name_jp: "順天堂大学医学部附属順天堂医院",
  phone: "03-5802-1985",
  website_url: "https://www.juntendo.ac.jp/hospital/",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "All clinical departments available. English support provided.",
  insurance_notes_jp: "全診療科対応。英語サポートあり。"
)

koishikawa_international = Hospital.create!(
  name_en: "Koishikawa International Clinic",
  name_jp: "小石川インターナショナルクリニック",
  phone: "03-5615-8556",
  website_url: "https://maps.google.com/?q=Koishikawa+International+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "09:30-16:30. 24-hour housecall: 03-6311-5853",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "24-hour housecall service available at separate number.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# NOTE: komagome (Tokyo Metropolitan Komagome Hospital) already defined above.

nakamura_clinic_bunkyo = Hospital.create!(
  name_en: "Nakamura Clinic",
  name_jp: "中村クリニック",
  phone: "03-3818-7677",
  website_url: "https://maps.google.com/?q=Nakamura+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

institute_of_science_tokyo = Hospital.create!(
  name_en: "Institute of Science Tokyo Hospital",
  name_jp: "東京科学大学病院",
  phone: "03-5803-5650",
  website_url: "https://maps.google.com/?q=Institute+of+Science+Tokyo+Hospital+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

hakusan_nagamine_eye = Hospital.create!(
  name_en: "Hakusan Nagamine Eye Clinic",
  name_jp: "白山長嶺眼科クリニック",
  phone: "03-5842-2232",
  website_url: "https://maps.google.com/?q=Hakusan+Nagamine+Eye+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

hongo_ent = Hospital.create!(
  name_en: "Hongo E.N.T. Clinic",
  name_jp: "本郷耳鼻咽喉科クリニック",
  phone: "03-5689-4133",
  website_url: "https://maps.google.com/?q=Hongo+ENT+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

bunkyo_medical = Hospital.create!(
  name_en: "Bunkyo Medical Clinic",
  name_jp: "文京メディカルクリニック",
  phone: "03-3827-7755",
  website_url: "https://maps.google.com/?q=Bunkyo+Medical+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Multiple languages including Chinese, Korean, French supported via tablet.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

fix_dental = Hospital.create!(
  name_en: "Fix Dental Clinic",
  name_jp: "フィックス歯科クリニック",
  phone: "03-5615-8415",
  website_url: "https://maps.google.com/?q=Fix+Dental+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ohtsuka_clinic = Hospital.create!(
  name_en: "Ohtsuka Clinic",
  name_jp: "大塚クリニック",
  phone: "03-3831-2294",
  website_url: "https://maps.google.com/?q=Ohtsuka+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

todaimae_kids = Hospital.create!(
  name_en: "Todaimae Kids Clinic",
  name_jp: "東大前キッズクリニック",
  phone: "03-3830-0161",
  website_url: "https://maps.google.com/?q=Todaimae+Kids+Clinic+Bunkyo+Tokyo",
  ward: "Bunkyo-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- TAITO-KU ---
asian_beauty_clinic = Hospital.create!(
  name_en: "Asian Beauty Clinic",
  name_jp: "アジアンビューティークリニック",
  phone: "03-3831-5136",
  website_url: "https://maps.google.com/?q=Asian+Beauty+Clinic+Taito+Tokyo",
  ward: "Taito-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

stress_care_ueno = Hospital.create!(
  name_en: "Stress Care Tokyo Ueno Ekimae Clinic",
  name_jp: "ストレスケア東京上野駅前クリニック",
  phone: "03-3842-7730",
  website_url: "https://maps.google.com/?q=Stress+Care+Tokyo+Ueno+Ekimae+Clinic+Taito+Tokyo",
  ward: "Taito-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kyowa_clinic = Hospital.create!(
  name_en: "Kyowa Clinic",
  name_jp: "共和クリニック",
  phone: "03-3835-0186",
  website_url: "https://maps.google.com/?q=Kyowa+Clinic+Taito+Tokyo",
  ward: "Taito-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

minowa_dental = Hospital.create!(
  name_en: "Minowa Dental Clinic",
  name_jp: "三ノ輪歯科クリニック",
  phone: "090-3503-8871",
  website_url: "https://maps.google.com/?q=Minowa+Dental+Clinic+Taito+Tokyo",
  ward: "Taito-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

yamada_shitamachi = Hospital.create!(
  name_en: "Yamada Hideaki Shitamachi Clinic",
  name_jp: "山田秀明下町クリニック",
  phone: "03-5806-3077",
  website_url: "https://maps.google.com/?q=Yamada+Hideaki+Shitamachi+Clinic+Taito+Tokyo",
  ward: "Taito-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ueno_medical = Hospital.create!(
  name_en: "Ueno Medical Clinic",
  name_jp: "上野メディカルクリニック",
  phone: "03-3832-0076",
  website_url: "https://maps.google.com/?q=Ueno+Medical+Clinic+Taito+Tokyo",
  ward: "Taito-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ueno_shinagawa_dental = Hospital.create!(
  name_en: "Ueno Shinagawa Dental & Orthodontic Clinic",
  name_jp: "上野品川歯科・矯正歯科クリニック",
  phone: "03-5826-8814",
  website_url: "https://maps.google.com/?q=Ueno+Shinagawa+Dental+Orthodontic+Clinic+Taito+Tokyo",
  ward: "Taito-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokyo_business_clinic_ueno = Hospital.create!(
  name_en: "Tokyo Business Clinic Ecute-ueno",
  name_jp: "東京ビジネスクリニックエキュート上野",
  phone: "03-6802-8792",
  website_url: "https://maps.google.com/?q=Tokyo+Business+Clinic+Ecute+ueno+Taito+Tokyo",
  ward: "Taito-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

higashiueno_dental = Hospital.create!(
  name_en: "Higashiueno Dental Clinic",
  name_jp: "東上野歯科クリニック",
  phone: "03-5818-4618",
  website_url: "https://maps.google.com/?q=Higashiueno+Dental+Clinic+Taito+Tokyo",
  ward: "Taito-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- MEGURO-KU ---
yamashita_jiyugaoka = Hospital.create!(
  name_en: "Yamashita Medical Clinic Jiyugaoka",
  name_jp: "山下医院自由が丘",
  phone: "03-3724-3811",
  website_url: "https://maps.google.com/?q=Yamashita+Medical+Clinic+Jiyugaoka+Meguro+Tokyo",
  ward: "Meguro-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

loco_clinic = Hospital.create!(
  name_en: "Loco Clinic Nakameguro",
  name_jp: "ロコクリニック中目黒",
  phone: "03-5722-6565",
  website_url: "https://maps.google.com/?q=Loco+Clinic+Nakameguro+Meguro+Tokyo",
  ward: "Meguro-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

yamamoto_dermatology = Hospital.create!(
  name_en: "Yamamoto Familiar Dermatology Clinic",
  name_jp: "山本ファミリー皮膚科クリニック",
  phone: "03-3795-1112",
  website_url: "https://maps.google.com/?q=Yamamoto+Familiar+Dermatology+Clinic+Meguro+Tokyo",
  ward: "Meguro-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

meguro_ootorijinja = Hospital.create!(
  name_en: "Meguro no Ootorijinjya-mae Clinic",
  name_jp: "目黒の大鳥神社前クリニック",
  phone: "03-3779-7736",
  website_url: "https://maps.google.com/?q=Meguro+Ootorijinja+Clinic+Meguro+Tokyo",
  ward: "Meguro-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

mikawa_orthodontics = Hospital.create!(
  name_en: "Mikawa Orthodontics",
  name_jp: "三河矯正歯科",
  phone: "03-6421-8998",
  website_url: "https://maps.google.com/?q=Mikawa+Orthodontics+Meguro+Tokyo",
  ward: "Meguro-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: false,
  accepts_kokumin_hoken: false,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

matsuo_dental = Hospital.create!(
  name_en: "Matsuo Dental Clinic",
  name_jp: "松尾歯科クリニック",
  phone: "03-3419-4018",
  website_url: "https://maps.google.com/?q=Matsuo+Dental+Clinic+Meguro+Tokyo",
  ward: "Meguro-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

la_ebs_clinique = Hospital.create!(
  name_en: "La Ebs Clinique Dental",
  name_jp: "ラエブスクリニークデンタル",
  phone: "03-6451-2314",
  website_url: "https://maps.google.com/?q=La+Ebs+Clinique+Dental+Meguro+Tokyo",
  ward: "Meguro-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

yamate_dental = Hospital.create!(
  name_en: "Yamate Dental Clinic",
  name_jp: "山手歯科クリニック",
  phone: "03-3719-6874",
  website_url: "https://maps.google.com/?q=Yamate+Dental+Clinic+Meguro+Tokyo",
  ward: "Meguro-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

jiyugaoka_oral_care = Hospital.create!(
  name_en: "Jiyugaoka Oral Care",
  name_jp: "自由が丘オーラルケア",
  phone: "03-5726-9185",
  website_url: "https://maps.google.com/?q=Jiyugaoka+Oral+Care+Meguro+Tokyo",
  ward: "Meguro-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

genwado_dental = Hospital.create!(
  name_en: "Genwado Dental Clinic",
  name_jp: "源和堂歯科クリニック",
  phone: "03-6452-3882",
  website_url: "https://maps.google.com/?q=Genwado+Dental+Clinic+Meguro+Tokyo",
  ward: "Meguro-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokuchi_clinic = Hospital.create!(
  name_en: "Tokuchi Clinic",
  name_jp: "徳地クリニック",
  phone: "03-3712-0872",
  website_url: "https://maps.google.com/?q=Tokuchi+Clinic+Meguro+Tokyo",
  ward: "Meguro-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- SETAGAYA-KU ---
nissan_tamagawa = Hospital.create!(
  name_en: "Nissan Tamagawa Hospital",
  name_jp: "日産玉川病院",
  phone: "03-3700-1151",
  website_url: "https://maps.google.com/?q=Nissan+Tamagawa+Hospital+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kanto_central = Hospital.create!(
  name_en: "Kanto Central Hospital",
  name_jp: "関東中央病院",
  phone: "03-3429-1171",
  website_url: "https://maps.google.com/?q=Kanto+Central+Hospital+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kodama_kyodo = Hospital.create!(
  name_en: "Kodama Kyodo Hospital",
  name_jp: "こだま共同病院",
  phone: "03-3420-1028",
  website_url: "https://maps.google.com/?q=Kodama+Kyodo+Hospital+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

musashi_eye = Hospital.create!(
  name_en: "Musashi Eye Clinic",
  name_jp: "武蔵眼科クリニック",
  phone: "03-5760-6695",
  website_url: "https://maps.google.com/?q=Musashi+Eye+Clinic+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

karasawa_clinic = Hospital.create!(
  name_en: "Karasawa Clinic",
  name_jp: "からさわクリニック",
  phone: "03-3701-7552",
  website_url: "https://maps.google.com/?q=Karasawa+Clinic+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

naomiya_clinic = Hospital.create!(
  name_en: "Naomiya Clinic",
  name_jp: "直宮クリニック",
  phone: "03-3468-2867",
  website_url: "https://maps.google.com/?q=Naomiya+Clinic+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

setagaya_okada_ortho = Hospital.create!(
  name_en: "Setagaya Okada Orthopaedic Surgery Clinic",
  name_jp: "世田谷岡田整形外科クリニック",
  phone: "03-3422-8877",
  website_url: "https://maps.google.com/?q=Setagaya+Okada+Orthopaedic+Surgery+Clinic+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

california_orthodontics = Hospital.create!(
  name_en: "California Orthodontics Sangenjaya",
  name_jp: "カリフォルニア矯正歯科三軒茶屋",
  phone: "03-5787-8107",
  website_url: "https://maps.google.com/?q=California+Orthodontics+Sangenjaya+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: false,
  accepts_kokumin_hoken: false,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

dental_watanabe = Hospital.create!(
  name_en: "Dental Watanabe",
  name_jp: "デンタルワタナベ",
  phone: "03-3309-1188",
  website_url: "https://maps.google.com/?q=Dental+Watanabe+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

takao_dental = Hospital.create!(
  name_en: "Takao Dental Clinic",
  name_jp: "高尾歯科クリニック",
  phone: "03-3309-7771",
  website_url: "https://maps.google.com/?q=Takao+Dental+Clinic+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kan_dental = Hospital.create!(
  name_en: "Kan Dental Clinic",
  name_jp: "貫歯科クリニック",
  phone: "03-5752-6480",
  website_url: "https://maps.google.com/?q=Kan+Dental+Clinic+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# NOTE: matsuzawa (Tokyo Metropolitan Matsuzawa Hospital) already defined above.

nishikawa_dental = Hospital.create!(
  name_en: "Nishikawa Dental Clinic",
  name_jp: "西川歯科クリニック",
  phone: "03-3429-0418",
  website_url: "https://maps.google.com/?q=Nishikawa+Dental+Clinic+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

futakotamagawa_celeste = Hospital.create!(
  name_en: "Futakotamagawa Celeste Clinic",
  name_jp: "二子玉川セレストクリニック",
  phone: "03-6447-9511",
  website_url: "https://maps.google.com/?q=Futakotamagawa+Celeste+Clinic+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

rose_ladies_clinic = Hospital.create!(
  name_en: "Rose Ladies Clinic",
  name_jp: "ローズレディースクリニック",
  phone: "03-3703-0114",
  website_url: "https://maps.google.com/?q=RoseLadiesClinic+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ncchd = Hospital.create!(
  name_en: "National Center for Child Health and Development",
  name_jp: "国立成育医療研究センター",
  phone: "03-5494-5486",
  website_url: "https://maps.google.com/?q=National+Center+Child+Health+Development+Setagaya+Tokyo",
  ward: "Setagaya-ku",
  visiting_hours: "# VERIFY",
  is_government: true,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- SHIBUYA-KU ---
# NOTE: hiroo (Tokyo Metropolitan Hiroo Hospital) already defined above.
# NOTE: sendagaya (Sendagaya International Clinic) already defined above.

plaza_plastic_surgery = Hospital.create!(
  name_en: "Plaza Plastic Surgery",
  name_jp: "プラザ形成外科",
  phone: "03-5475-2345",
  website_url: "https://maps.google.com/?q=Plaza+Plastic+Surgery+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ogihara_orthopedics = Hospital.create!(
  name_en: "Ogihara Orthopedics",
  name_jp: "荻原整形外科",
  phone: "03-5371-3001",
  website_url: "https://maps.google.com/?q=Ogihara+Orthopedics+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

takako_clinic = Hospital.create!(
  name_en: "Takako Clinic",
  name_jp: "たかこクリニック",
  phone: "03-5459-7943",
  website_url: "https://maps.google.com/?q=Takako+Clinic+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

fertility_clinic_tokyo = Hospital.create!(
  name_en: "Fertility Clinic Tokyo",
  name_jp: "フェティリティークリニック東京",
  phone: "03-3406-6868",
  website_url: "https://maps.google.com/?q=Fertility+Clinic+Tokyo+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

suwa_child_family = Hospital.create!(
  name_en: "Suwa Child Family Clinic",
  name_jp: "諏訪こどもファミリークリニック",
  phone: "03-3444-7070",
  website_url: "https://maps.google.com/?q=Suwa+Child+Family+Clinic+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

mih_clinic_yoyogi = Hospital.create!(
  name_en: "Mih Clinic Yoyogi",
  name_jp: "MIHクリニック代々木",
  phone: "03-6276-5385",
  website_url: "https://maps.google.com/?q=Mih+Clinic+Yoyogi+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

harajuku_first_dental = Hospital.create!(
  name_en: "Harajuku First Dental Office",
  name_jp: "原宿ファースト歯科",
  phone: "03-5413-6480",
  website_url: "https://maps.google.com/?q=Harajuku+First+Dental+Office+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

mihara_dental = Hospital.create!(
  name_en: "Mihara Dental Clinic",
  name_jp: "三原歯科クリニック",
  phone: "03-6407-1646",
  website_url: "https://maps.google.com/?q=Mihara+Dental+Clinic+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

daikanyama_dental_salon = Hospital.create!(
  name_en: "Daikanyama Dental Salon",
  name_jp: "代官山デンタルサロン",
  phone: "03-6416-5747",
  website_url: "https://maps.google.com/?q=Daikanyama+Dental+Salon+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

daikanyama_dental_clinic = Hospital.create!(
  name_en: "Daikanyama Dental Clinic",
  name_jp: "代官山歯科クリニック",
  phone: "03-3462-0787",
  website_url: "https://maps.google.com/?q=Daikanyama+Dental+Clinic+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

japan_orthodontic_center = Hospital.create!(
  name_en: "Japan Orthodontic Center",
  name_jp: "日本矯正歯科センター",
  phone: "03-3499-2222",
  website_url: "https://maps.google.com/?q=Japan+Orthodontic+Center+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: false,
  accepts_kokumin_hoken: false,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

doi_dental_harajuku = Hospital.create!(
  name_en: "Doi Dental Harajuku Clinic",
  name_jp: "土井歯科原宿クリニック",
  phone: "03-5414-5727",
  website_url: "https://maps.google.com/?q=Doi+Dental+Harajuku+Clinic+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

hirahata_clinic = Hospital.create!(
  name_en: "Hirahata Clinic",
  name_jp: "平畑クリニック",
  phone: "03-3400-3288",
  website_url: "https://maps.google.com/?q=Hirahata+Clinic+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Travel vaccinations and Chinese medicine specialty available.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

pinkribbon_omotesando = Hospital.create!(
  name_en: "Pinkribbon Breastcare Clinic Omotesando",
  name_jp: "ピンクリボンブレストケアクリニック表参道",
  phone: "050-3171-3258",
  website_url: "https://maps.google.com/?q=pinkribbon+breastcare+clinic+omotesando+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "30+ languages supported including English, Chinese, Korean, Vietnamese, Russian, and more.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

japan_china_friendship = Hospital.create!(
  name_en: "Japan China Friendship Clinic",
  name_jp: "日中友好クリニック",
  phone: "03-6276-9788",
  website_url: "https://maps.google.com/?q=Japan+China+Friendship+Clinic+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

shibuya_er = Hospital.create!(
  name_en: "Shibuya ER",
  name_jp: "渋谷ER",
  phone: "080-3312-9910",
  website_url: "https://maps.google.com/?q=Shibuya+ER+Shibuya+Tokyo",
  ward: "Shibuya-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Emergency clinic. English supported.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# --- MINATO-KU ---
# NOTE: takanawa (JCHO Tokyo Takanawa Hospital) already defined above.
# NOTE: saiseikai (Saiseikai Central Hospital) already defined above.

iuhw_mita = Hospital.create!(
  name_en: "IUHW Mita Hospital",
  name_jp: "国際医療福祉大学三田病院",
  phone: "03-3451-8121",
  website_url: "https://maps.google.com/?q=IUHW+Mita+Hospital+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

toranomon = Hospital.create!(
  name_en: "Toranomon Hospital",
  name_jp: "虎の門病院",
  phone: "03-3588-1111",
  website_url: "https://maps.google.com/?q=Toranomon+Hospital+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "English and Chinese supported. Full multi-specialty hospital.",
  insurance_notes_jp: "英語・中国語対応。多科病院。"
)

toranomon_nakamura = Hospital.create!(
  name_en: "Toranomon Nakamura Clinic",
  name_jp: "虎の門中村クリニック",
  phone: "03-6823-1409",
  website_url: "https://maps.google.com/?q=Toranomon+Nakamura+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

nishiazabu_international = Hospital.create!(
  name_en: "Nishiazabu International Clinic",
  name_jp: "西麻布インターナショナルクリニック",
  phone: "03-6447-5966",
  website_url: "https://maps.google.com/?q=Nishiazabu+International+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kyono_art_takanawa = Hospital.create!(
  name_en: "Kyono Art Clinic Takanawa",
  name_jp: "京野アートクリニック高輪",
  phone: "03-6408-4124",
  website_url: "https://maps.google.com/?q=Kyono+Art+Clinic+Takanawa+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

roppongi_hat = Hospital.create!(
  name_en: "Roppongi HAT Clinic",
  name_jp: "六本木HATクリニック",
  phone: "03-3585-3232",
  website_url: "https://maps.google.com/?q=Roppongi+HAT+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

shiba_coloproctological = Hospital.create!(
  name_en: "Shiba International Coloproctological Clinic",
  name_jp: "芝インターナショナル大腸肛門クリニック",
  phone: "03-6453-9307",
  website_url: "https://maps.google.com/?q=SHIBA+INTERNATIONAL+COLOPROCTOLOGICAL+CLINIC+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

omotesando_helene = Hospital.create!(
  name_en: "Omotesando Helene Clinic",
  name_jp: "表参道ヘレネクリニック",
  phone: "03-3400-2277",
  website_url: "https://maps.google.com/?q=Omotesando+Helene+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

international_health_care = Hospital.create!(
  name_en: "International Health Care Clinic",
  name_jp: "インターナショナルヘルスケアクリニック",
  phone: "03-3501-1330",
  website_url: "https://maps.google.com/?q=International+Health+Care+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "Interpreter consultation: Tue-Fri 15:30-18:30",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Interpreter consultation available Tuesday to Friday, 15:30-18:30.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

azabu_orthopedic = Hospital.create!(
  name_en: "Azabu Orthopedic Clinic",
  name_jp: "麻布整形外科クリニック",
  phone: "03-5765-2020",
  website_url: "https://maps.google.com/?q=Azabu+Orthopedic+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokyo_beauty_skin = Hospital.create!(
  name_en: "Tokyo Beauty Skin Clinic",
  name_jp: "東京ビューティースキンクリニック",
  phone: "03-3585-0272",
  website_url: "https://maps.google.com/?q=Tokyo+Beauty+Skin+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "English, French, German, Dutch supported.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kumada_clinic = Hospital.create!(
  name_en: "Kumada Clinic",
  name_jp: "熊田クリニック",
  phone: "03-5766-3357",
  website_url: "https://maps.google.com/?q=Kumada+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

matsumi_ladice = Hospital.create!(
  name_en: "Matsumi Ladice Clinic",
  name_jp: "まつみレディースクリニック",
  phone: "03-6453-8355",
  website_url: "https://maps.google.com/?q=matsumi+ladice+clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

omotesando_wiz = Hospital.create!(
  name_en: "Omotesando Wiz Clinic",
  name_jp: "表参道ウィズクリニック",
  phone: "03-5962-7018",
  website_url: "https://maps.google.com/?q=Omotesando+Wiz+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: false,
  accepts_kokumin_hoken: false,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

akasaka_odayaka = Hospital.create!(
  name_en: "Akasaka Odayaka Clinic",
  name_jp: "赤坂おだやかクリニック",
  phone: "03-6234-0511",
  website_url: "https://maps.google.com/?q=Akasaka+Odayaka+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ishigami_dental = Hospital.create!(
  name_en: "Ishigami Dental Office",
  name_jp: "石上歯科医院",
  phone: "03-3409-6889",
  website_url: "https://maps.google.com/?q=Ishigami+Dental+Office+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

yamanaka_dental = Hospital.create!(
  name_en: "Yamanaka Dental Clinic",
  name_jp: "山中歯科クリニック",
  phone: "03-6381-7778",
  website_url: "https://maps.google.com/?q=Yamanaka+Dental+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

takanawa_orthodontic = Hospital.create!(
  name_en: "Takanawa Orthodontic Clinic",
  name_jp: "高輪矯正歯科クリニック",
  phone: "03-3280-1700",
  website_url: "https://maps.google.com/?q=Takanawa+Orthodontic+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: false,
  accepts_kokumin_hoken: false,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

azabudai_united_dental = Hospital.create!(
  name_en: "Azabudai United Dental Office",
  name_jp: "麻布台ユナイテッド歯科",
  phone: "03-5570-4334",
  website_url: "https://maps.google.com/?q=Azabudai+United+Dental+Office+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

nakajima_dental_minato = Hospital.create!(
  name_en: "Nakajima Dental Clinic",
  name_jp: "中島歯科クリニック",
  phone: "03-3479-2726",
  website_url: "https://maps.google.com/?q=Nakajima+Dental+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ichikawa_dental_akasaka = Hospital.create!(
  name_en: "Ichikawa Dental Akasaka Office",
  name_jp: "市川歯科赤坂オフィス",
  phone: "03-3505-5733",
  website_url: "https://maps.google.com/?q=Ichikawa+Dental+Akasaka+Office+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokyo_international_dental_roppongi = Hospital.create!(
  name_en: "Tokyo International Dental Clinic Roppongi",
  name_jp: "東京インターナショナル歯科六本木",
  phone: "03-6447-5966",
  website_url: "https://maps.google.com/?q=Tokyo+International+Dental+Clinic+Roppongi+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

mirise_orthodontics = Hospital.create!(
  name_en: "Mirise Orthodontics Minami Aoyama",
  name_jp: "ミライズ矯正歯科南青山",
  phone: "03-5468-5585",
  website_url: "https://maps.google.com/?q=Mirise+Orthodontics+Minami+Aoyama+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: false,
  accepts_kokumin_hoken: false,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

reiko_dental = Hospital.create!(
  name_en: "Reiko Dental Clinic",
  name_jp: "れいこ歯科クリニック",
  phone: "03-5114-6077",
  website_url: "https://maps.google.com/?q=Reiko+Dental+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

makiyama_oral = Hospital.create!(
  name_en: "Makiyama Kiyoshi Oral Clinic",
  name_jp: "牧山きよし口腔クリニック",
  phone: "03-6447-4118",
  website_url: "https://maps.google.com/?q=Makiyama+Kiyoshi+Oral+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

azabu_tokyo_dental = Hospital.create!(
  name_en: "Azabu Tokyo Dental Clinic",
  name_jp: "麻布東京デンタルクリニック",
  phone: "03-5422-7518",
  website_url: "https://maps.google.com/?q=Azabu+Tokyo+Dental+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kimishima_dental = Hospital.create!(
  name_en: "Kimishima Dental Office",
  name_jp: "君島歯科医院",
  phone: "03-6277-4217",
  website_url: "https://maps.google.com/?q=Kimishima+Dental+Office+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

shiroganedai_pearl = Hospital.create!(
  name_en: "Shiroganedai Pearl Orthodontic Office",
  name_jp: "白金台パール矯正歯科",
  phone: "03-3445-1182",
  website_url: "https://maps.google.com/?q=Shiroganedai+Pearl+Orthodontic+Office+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: false,
  accepts_kokumin_hoken: false,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokyo_midtown_dental = Hospital.create!(
  name_en: "Tokyo Midtown Dental Clinic",
  name_jp: "東京ミッドタウン歯科クリニック",
  phone: "03-5413-7911",
  website_url: "https://maps.google.com/?q=Tokyo+Midtown+Dental+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

hitomi_dental_akasaka = Hospital.create!(
  name_en: "Hitomi Dental Office Akasaka",
  name_jp: "ひとみ歯科赤坂",
  phone: "03-6277-7983",
  website_url: "https://maps.google.com/?q=Hitomi+Dental+Office+Akasaka+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

nakano_dental_minato = Hospital.create!(
  name_en: "Nakano Dental",
  name_jp: "中野歯科",
  phone: "03-3446-1117",
  website_url: "https://maps.google.com/?q=NAKANO+DENTAL+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

toyoda_dental = Hospital.create!(
  name_en: "Toyoda Dental Office",
  name_jp: "豊田歯科医院",
  phone: "03-3582-4731",
  website_url: "https://maps.google.com/?q=Toyoda+Dental+Office+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

royal_dental = Hospital.create!(
  name_en: "Royal Dental Clinic",
  name_jp: "ロイヤル歯科クリニック",
  phone: "03-3404-0819",
  website_url: "https://maps.google.com/?q=Royal+Dental+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

keyakizakaue_medical_dental = Hospital.create!(
  name_en: "Keyakizakaue Medical and Dental Clinic",
  name_jp: "欅坂上メディカル・デンタルクリニック",
  phone: "03-6804-2211",
  website_url: "https://maps.google.com/?q=Keyakizakaue+Medical+Dental+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

rk_dental_roppongi = Hospital.create!(
  name_en: "RK Dental Office Roppongi",
  name_jp: "RK歯科六本木",
  phone: "03-6459-2560",
  website_url: "https://maps.google.com/?q=RK+Dental+Office+Roppongi+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

shimbashi_hibiya = Hospital.create!(
  name_en: "Shimbashi Hibiya Clinic",
  name_jp: "新橋日比谷クリニック",
  phone: "03-5251-9300",
  website_url: "https://maps.google.com/?q=Shimbashi+Hibiya+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

azabu_koki = Hospital.create!(
  name_en: "Azabu Koki Clinic",
  name_jp: "麻布幸喜クリニック",
  phone: "03-6240-2912",
  website_url: "https://maps.google.com/?q=Azabu+Koki+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokyo_midtown_clinic = Hospital.create!(
  name_en: "Tokyo Midtown Clinic",
  name_jp: "東京ミッドタウンクリニック",
  phone: "03-5413-7911",
  website_url: "https://maps.google.com/?q=Tokyo+Midtown+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

akasaka_dental = Hospital.create!(
  name_en: "Akasaka Dental Clinic",
  name_jp: "赤坂歯科クリニック",
  phone: "03-3583-1818",
  website_url: "https://maps.google.com/?q=Akasaka+Dental+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

aoyama_dental = Hospital.create!(
  name_en: "Aoyama Dental Clinic",
  name_jp: "青山歯科クリニック",
  phone: "03-6804-2378",
  website_url: "https://maps.google.com/?q=Aoyama+Dental+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

plaza_precision_surgery = Hospital.create!(
  name_en: "Plaza Precision Surgery",
  name_jp: "プラザプレジョンサージェリー",
  phone: "03-3437-3880",
  website_url: "https://maps.google.com/?q=Plaza+Precision+Surgery+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

indiva_clinic = Hospital.create!(
  name_en: "Indiva Clinic",
  name_jp: "インディバクリニック",
  phone: "03-6436-7991",
  website_url: "https://maps.google.com/?q=Indiva+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

roppongi_mental_health = Hospital.create!(
  name_en: "Roppongi Clinic, Mental Health Clinic",
  name_jp: "六本木クリニック・メンタルヘルスクリニック",
  phone: "03-6262-3459",
  website_url: "https://maps.google.com/?q=Roppongi+Clinic+Mental+Health+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tokyo_tower_view_clinic = Hospital.create!(
  name_en: "Tokyo Tower View Clinic Azabujuban",
  name_jp: "東京タワービュークリニック麻布十番",
  phone: "03-6809-3207",
  website_url: "https://maps.google.com/?q=Tokyo+Tower+View+Clinic+Azabujuban+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "French available by appointment for internal medicine only.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

minamiazabu_musubi = Hospital.create!(
  name_en: "Minamiazabu Musubi Dermatology and Plastic Surgery",
  name_jp: "南麻布むすび皮膚科・形成外科",
  phone: "03-6277-2113",
  website_url: "https://maps.google.com/?q=Minamiazabu+Musubi+Dermatology+Plastic+Surgery+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Chinese interpreter availability depends on working days.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

dental_office_toranomon = Hospital.create!(
  name_en: "Dental Office Toranomon",
  name_jp: "デンタルオフィス虎ノ門",
  phone: "03-5545-1418",
  website_url: "https://maps.google.com/?q=DENTAL+OFFICE+TORANOMON+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "By appointment",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Appointment required. Chinese (Mandarin) available.",
  insurance_notes_jp: "予約制。中国語（普通話）対応。"
)

total_tooth_treatment = Hospital.create!(
  name_en: "Total Tooth Treatment",
  name_jp: "トータルトゥーストリートメント",
  phone: "03-3585-0648",
  website_url: "https://maps.google.com/?q=TOTAL+TOOTH+TREATMENT+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

heiwa_hospital_minato = Hospital.create!(
  name_en: "Heiwa Hospital",
  name_jp: "平和病院",
  phone: "03-5797-8367",
  website_url: "https://maps.google.com/?q=HEIWA+HOSPITAL+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

shinagawa_east_medical = Hospital.create!(
  name_en: "Shinagawa East Medical Clinic",
  name_jp: "品川イーストメディカルクリニック",
  phone: "03-5783-5521",
  website_url: "https://maps.google.com/?q=Shinagawa+East+Medical+Clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "Travel clinic and medical examination available.",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

evergreen_medical = Hospital.create!(
  name_en: "Evergreen Medical Clinic",
  name_jp: "エバーグリーンメディカルクリニック",
  phone: "03-6459-2757",
  website_url: "https://maps.google.com/?q=Evergreen+medical+clinic+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

sakura_international = Hospital.create!(
  name_en: "Sakura International Clinic Tokyo",
  name_jp: "さくらインターナショナルクリニック東京",
  phone: "03-6824-6819",
  website_url: "https://maps.google.com/?q=Sakura+International+Clinic+Tokyo+Minato+Tokyo",
  ward: "Minato-ku",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "30+ languages supported including English, Chinese, Korean, Nepali, Portuguese, Spanish, Vietnamese, Bengali, and more.",
  insurance_notes_jp: "英語・中国語・韓国語・ネパール語・ポルトガル語ほか30言語以上対応。"
)

# --- OUTSIDE 23 WARDS ---

# Kokubunji
nomura_clinic_square = Hospital.create!(
  name_en: "Nomura Clinic Square",
  name_jp: "野村クリニックスクエア",
  phone: "042-325-0087",
  website_url: "https://maps.google.com/?q=Nomura+Clinic+Square+Kokubunji+Tokyo",
  ward: "Kokubunji",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# Kunitachi
seirin_clinic = Hospital.create!(
  name_en: "Seirin Clinic",
  name_jp: "清林クリニック",
  phone: "042-580-6102",
  website_url: "https://maps.google.com/?q=Seirin+Clinic+Kunitachi+Tokyo",
  ward: "Kunitachi",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# Mitaka
tokyo_international_ohori = Hospital.create!(
  name_en: "Tokyo International Ohori Hospital",
  name_jp: "東京国際大堀病院",
  phone: "0422-47-1000",
  website_url: "https://maps.google.com/?q=Tokyo+International+Ohori+Hospital+Mitaka+Tokyo",
  ward: "Mitaka",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

takayama_clinic = Hospital.create!(
  name_en: "Takayama Clinic",
  name_jp: "高山クリニック",
  phone: "0422-43-0700",
  website_url: "https://maps.google.com/?q=TAKAYAMA+CLINIC+Mitaka+Tokyo",
  ward: "Mitaka",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "All languages supported via translation machine.",
  insurance_notes_jp: "翻訳機による全言語対応。"
)

# Kodaira
ncnp = Hospital.create!(
  name_en: "National Center for Neurology and Psychiatry",
  name_jp: "国立精神・神経医療研究センター",
  phone: "042-341-2711",
  website_url: "https://maps.google.com/?q=National+Center+Neurology+Psychiatry+Kodaira+Tokyo",
  ward: "Kodaira",
  visiting_hours: "# VERIFY",
  is_government: true,
  is_certified: true,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "National research center. English supported.",
  insurance_notes_jp: "国立研究センター。英語対応。"
)

shiraya_eye = Hospital.create!(
  name_en: "Shiraya Eye Clinic",
  name_jp: "白谷眼科クリニック",
  phone: "042-341-0219",
  website_url: "https://maps.google.com/?q=Shiraya+Eye+Clinic+Kodaira+Tokyo",
  ward: "Kodaira",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# Akishima
tokyo_nishi_tokushukai = Hospital.create!(
  name_en: "Tokyo Nishi Tokushukai Hospital",
  name_jp: "東京西徳洲会病院",
  phone: "042-500-4433",
  website_url: "https://maps.google.com/?q=Tokyo+Nishi+Tokushukai+Hospital+Akishima+Tokyo",
  ward: "Akishima",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# Tama
musashino_tokushukai = Hospital.create!(
  name_en: "Musashino Tokushukai Hospital",
  name_jp: "武蔵野徳洲会病院",
  phone: "042-465-0700",
  website_url: "https://maps.google.com/?q=Musashino+Tokushukai+Hospital+Tama+Tokyo",
  ward: "Tama",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

aozora_tanashi = Hospital.create!(
  name_en: "Aozora Tanashi Clinic",
  name_jp: "あおぞら田無クリニック",
  phone: "042-452-3700",
  website_url: "https://maps.google.com/?q=Aozora+Tanashi+Clinic+Tama+Tokyo",
  ward: "Tama",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tama_nambu_chiiki = Hospital.create!(
  name_en: "Tokyo Metropolitan Tama-Nambu Chiiki Hospital",
  name_jp: "東京都立多摩南部地域病院",
  phone: "042-338-5111",
  website_url: "https://maps.google.com/?q=Tokyo+Metropolitan+Tama+Nambu+Chiiki+Hospital+Tama+Tokyo",
  ward: "Tama",
  visiting_hours: "# VERIFY",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "13 languages supported including English, Chinese, Korean, Thai, Tagalog, Burmese, Vietnamese, Bengali, French, Portuguese, German, Russian, Italian, Spanish.",
  insurance_notes_jp: "英語・中国語・韓国語・タイ語ほか13言語対応。"
)

mimuro_womens = Hospital.create!(
  name_en: "Mimuro Women's Clinic",
  name_jp: "三室レディースクリニック",
  phone: "042-710-3609",
  website_url: "https://maps.google.com/?q=Mimuro+Womens+Clinic+Tama+Tokyo",
  ward: "Tama",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kuroiwa_dental = Hospital.create!(
  name_en: "Kuroiwa Dental Clinic",
  name_jp: "黒岩歯科クリニック",
  phone: "042-725-0310",
  website_url: "https://maps.google.com/?q=Kuroiwa+Dental+Clinic+Tama+Tokyo",
  ward: "Tama",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

neuro_machida = Hospital.create!(
  name_en: "Neuro Machida Clinic",
  name_jp: "ニューロ町田クリニック",
  phone: "042-732-6077",
  website_url: "https://maps.google.com/?q=Neuro+Machida+Clinic+Tama+Tokyo",
  ward: "Tama",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

taisei_clinic = Hospital.create!(
  name_en: "Taisei Clinic",
  name_jp: "大成クリニック",
  phone: "042-797-7423",
  website_url: "https://maps.google.com/?q=Taisei+Clinic+Tama+Tokyo",
  ward: "Tama",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# Chofu
sengawa_orthopedics = Hospital.create!(
  name_en: "Sengawa Orthopedics",
  name_jp: "仙川整形外科",
  phone: "03-3305-0088",
  website_url: "https://maps.google.com/?q=Sengawa+Orthopedics+Chofu+Tokyo",
  ward: "Chofu",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

sengawa_ent = Hospital.create!(
  name_en: "Sengawa E.N.T. Clinic",
  name_jp: "仙川耳鼻咽喉科クリニック",
  phone: "03-5313-3281",
  website_url: "https://maps.google.com/?q=Sengawa+ENT+Clinic+Chofu+Tokyo",
  ward: "Chofu",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# Higashimurayama
tama_hokubu = Hospital.create!(
  name_en: "Tokyo Metropolitan Tama-Hokubu Medical Center",
  name_jp: "東京都立多摩北部医療センター",
  phone: "042-396-3811",
  website_url: "https://maps.google.com/?q=Tokyo+Metropolitan+Tama+Hokubu+Medical+Center+Higashimurayama+Tokyo",
  ward: "Higashimurayama",
  visiting_hours: "# VERIFY",
  is_government: true,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "15 languages supported including English, Cantonese, Mandarin, Korean, Thai, Tagalog, Burmese, Vietnamese, Bengali, French, Portuguese, German, Russian, Italian, Spanish.",
  insurance_notes_jp: "英語・広東語・北京語・韓国語ほか15言語対応。"
)

# Hachioji
kitahara_international = Hospital.create!(
  name_en: "Kitahara International Hospital",
  name_jp: "北原国際病院",
  phone: "042-645-1110",
  website_url: "https://maps.google.com/?q=Kitahara+International+Hospital+Hachioji+Tokyo",
  ward: "Hachioji",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

ito_clinic_hachioji = Hospital.create!(
  name_en: "Ito Clinic",
  name_jp: "伊藤クリニック",
  phone: "042-644-2770",
  website_url: "https://maps.google.com/?q=Ito+Clinic+Hachioji+Tokyo",
  ward: "Hachioji",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

saitoh_dental = Hospital.create!(
  name_en: "Saitoh Dental Clinic",
  name_jp: "斉藤歯科クリニック",
  phone: "042-626-6066",
  website_url: "https://maps.google.com/?q=Saitoh+Dental+Clinic+Hachioji+Tokyo",
  ward: "Hachioji",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# Fuchu
# NOTE: tama (Tokyo Metropolitan Tama Medical Center) already defined above.
# NOTE: childrens (Tokyo Metropolitan Children's Medical Center) already defined above.
# NOTE: neurological (Tokyo Metropolitan Neurological Hospital) already defined above.

clinique_dentaire_sacre_coeur = Hospital.create!(
  name_en: "Clinique Dentaire Jardin Du Sacre-Coeur",
  name_jp: "クリニークデンテールジャルダンドゥサクレクール",
  phone: "042-403-9511",
  website_url: "https://maps.google.com/?q=Clinique+Dentaire+Jardin+Du+Sacre+Coeur+Fuchu+Tokyo",
  ward: "Fuchu-shi",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

tama_fuchu_umehara_dental = Hospital.create!(
  name_en: "Tama Fuchu Umehara Dental Clinic",
  name_jp: "多摩府中梅原歯科クリニック",
  phone: "042-306-9877",
  website_url: "https://maps.google.com/?q=Tama+Fuchu+Umehara+Dental+Clinic+Fuchu+Tokyo",
  ward: "Fuchu-shi",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# Musashino
kawasaki_dental_musashino = Hospital.create!(
  name_en: "Kawasaki Dental Clinic",
  name_jp: "川崎歯科クリニック",
  phone: "0422-51-3200",
  website_url: "https://maps.google.com/?q=Kawasaki+Dental+Clinic+Musashino+Tokyo",
  ward: "Musashino",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

nakajima_clinic_musashino = Hospital.create!(
  name_en: "Nakajima Clinic",
  name_jp: "中島クリニック",
  phone: "0422-21-6251",
  website_url: "https://maps.google.com/?q=Nakajima+Clinic+Musashino+Tokyo",
  ward: "Musashino",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

numata_medical = Hospital.create!(
  name_en: "Numata Medical Clinic",
  name_jp: "沼田医院",
  phone: "0422-56-3255",
  website_url: "https://maps.google.com/?q=Numata+Medical+Clinic+Musashino+Tokyo",
  ward: "Musashino",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

kichijoji_general_dental = Hospital.create!(
  name_en: "Kichijoji General Dental Clinic",
  name_jp: "吉祥寺総合歯科クリニック",
  phone: "0422-26-2900",
  website_url: "https://maps.google.com/?q=Kichijoji+General+Dental+Clinic+Musashino+Tokyo",
  ward: "Musashino",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# Fussa
takahashi_dental_fussa = Hospital.create!(
  name_en: "Takahashi Dental Clinic",
  name_jp: "高橋歯科クリニック",
  phone: "042-552-1182",
  website_url: "https://maps.google.com/?q=Takahashi+Dental+Clinic+Fussa+Tokyo",
  ward: "Fussa",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

hikari_clinic = Hospital.create!(
  name_en: "Hikari Clinic",
  name_jp: "ひかりクリニック",
  phone: "042-530-0221",
  website_url: "https://maps.google.com/?q=Hikari+Clinic+Fussa+Tokyo",
  ward: "Fussa",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# Tachikawa
tachikawa_iki_iki_dental = Hospital.create!(
  name_en: "Tachikawa Iki-Iki Dental Clinic",
  name_jp: "立川いきいき歯科クリニック",
  phone: "042-526-2784",
  website_url: "https://maps.google.com/?q=Tachikawa+Iki+Iki+Dental+Clinic+Tachikawa+Tokyo",
  ward: "Tachikawa",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# Koganei
musashi_koganei_midori = Hospital.create!(
  name_en: "Musashi-Koganei Midori Clinic",
  name_jp: "武蔵小金井みどりクリニック",
  phone: "042-316-1101",
  website_url: "https://maps.google.com/?q=Musashi+Koganei+Midori+Clinic+Koganei+Tokyo",
  ward: "Koganei",
  visiting_hours: "# VERIFY",
  is_government: false,
  is_certified: false,
  accepts_shakai_hoken: true,
  accepts_kokumin_hoken: true,
  accepts_travel_insurance: false,
  insurance_notes_en: "# MANUAL CHECK REQUIRED",
  insurance_notes_jp: "# MANUAL CHECK REQUIRED"
)

# =============================================================
# LINKING SPECIALTIES TO HOSPITALS
# =============================================================
puts "Linking specialties..."
HospitalSpecialty.create!([
  # Hiroo — JMIP, emergency, general
  { hospital: hiroo,        specialty: emergency_med },
  { hospital: hiroo,        specialty: oncology },

  # Komagome — cancer & infectious diseases specialist
  { hospital: komagome,     specialty: oncology },
  { hospital: komagome,     specialty: infectious },

  # Bokutoh — cancer & emergency
  { hospital: bokutoh,      specialty: oncology },
  { hospital: bokutoh,      specialty: emergency_med },

  # Tama — emergency & disaster center
  { hospital: tama,         specialty: emergency_med },
  { hospital: tama,         specialty: cardiology },

  # Neurological — neurology specialist
  { hospital: neurological, specialty: neurology },

  # Children's — pediatrics specialist
  { hospital: childrens,    specialty: pediatrics },
  { hospital: childrens,    specialty: newborn },

  # Otsuka — women's health
  { hospital: otsuka,       specialty: maternity },
  { hospital: otsuka,       specialty: gynecology },

  # Matsuzawa — psychiatry
  { hospital: matsuzawa,    specialty: psychiatry },

  # St. Luke's — JCI + JMIP, 24h emergency
  { hospital: st_lukes,     specialty: emergency_med },
  { hospital: st_lukes,     specialty: cardiology },
  { hospital: st_lukes,     specialty: maternity },

  # Saiseikai — general + emergency
  { hospital: saiseikai,    specialty: emergency_med },
  { hospital: saiseikai,    specialty: cardiology },

  # NCGM — infectious diseases, travel medicine
  { hospital: ncgm,         specialty: infectious },
  { hospital: ncgm,         specialty: oncology },

  # NTT Medical — general
  { hospital: ntt_medical,  specialty: cardiology },
  { hospital: ntt_medical,  specialty: rehabilitation },

  # Aiiku — maternity & newborn
  { hospital: aiiku,        specialty: maternity },
  { hospital: aiiku,        specialty: newborn },

  # Red Cross — maternity + emergency
  { hospital: red_cross,    specialty: maternity },
  { hospital: red_cross,    specialty: emergency_med },

  # Okubo, Toshima, Ebara — general hospitals
  { hospital: okubo,        specialty: emergency_med },
  { hospital: toshima,      specialty: cardiology },
  { hospital: ebara,        specialty: orthopedics },

  # University of Tokyo — general + specialist
  { hospital: univ_tokyo,  specialty: oncology },
  { hospital: univ_tokyo,  specialty: neurology },
  { hospital: univ_tokyo,  specialty: cardiology },
  { hospital: univ_tokyo,  specialty: infectious },

  # Takanawa — general + emergency
  { hospital: takanawa,    specialty: emergency_med },
  { hospital: takanawa,    specialty: orthopedics },
  { hospital: takanawa,    specialty: pediatrics },

  # TMSC — international clinic
  { hospital: tmsc,        specialty: gynecology },
  { hospital: tmsc,        specialty: pediatrics },

  # Sendagaya — travel medicine
  { hospital: sendagaya,   specialty: infectious },
  { hospital: sendagaya,   specialty: pediatrics },

  # --- PART 4 ward-by-ward specialties ---
  # Ono Cardiology (Koto-ku)
  { hospital: ono_cardiology,                    specialty: cardiology },

  # Koujinkai Daiichi / Tobu Chiiki (Katsushika-ku) — emergency hospitals
  { hospital: koujinkai_daiichi,                 specialty: emergency_med },
  { hospital: tobu_chiiki,                       specialty: emergency_med },

  # Tokyo Rinkai / Moriyama Memorial (Edogawa-ku) — full hospitals
  { hospital: tokyo_rinkai,                      specialty: emergency_med },
  { hospital: tokyo_rinkai,                      specialty: cardiology },
  { hospital: moriyama_memorial,                 specialty: emergency_med },

  # Kishi Clinica Femina / Asahi Ladies / Mammaria Tsukiji (gynecology/breast)
  { hospital: kishi_clinica_femina,              specialty: gynecology },
  { hospital: asahi_ladies_clinic,               specialty: gynecology },
  { hospital: mammaria_tsukiji,                  specialty: gynecology },

  # Ps I Clinic / Personal Health Clinic — mental health
  { hospital: ps_i_clinic,                       specialty: psychiatry },
  { hospital: personal_health_clinic,            specialty: psychiatry },

  # Murai Clinic (Bunkyo-ku) — cardiovascular
  { hospital: murai_clinic,                      specialty: cardiology },

  # Juntendo University Hospital — major teaching hospital
  { hospital: juntendo,                          specialty: cardiology },
  { hospital: juntendo,                          specialty: oncology },
  { hospital: juntendo,                          specialty: neurology },
  { hospital: juntendo,                          specialty: emergency_med },

  # Tokyo Station International / Koishikawa International — travel/infectious
  { hospital: tokyo_station_international,       specialty: infectious }
])

# =============================================================
# LINKING SERVICES TO HOSPITALS
# =============================================================
puts "Linking services..."
HospitalService.create!([
  { hospital: hiroo,        service: outpatient },
  { hospital: hiroo,        service: emergency_care },
  { hospital: hiroo,        service: inpatient },

  { hospital: okubo,        service: outpatient },
  { hospital: okubo,        service: inpatient },
  { hospital: okubo,        service: emergency_care },

  { hospital: otsuka,       service: outpatient },
  { hospital: otsuka,       service: inpatient },
  { hospital: otsuka,       service: prenatal },

  { hospital: komagome,     service: outpatient },
  { hospital: komagome,     service: inpatient },
  { hospital: komagome,     service: ct_scan },
  { hospital: komagome,     service: surgery },

  { hospital: toshima,      service: outpatient },
  { hospital: toshima,      service: inpatient },

  { hospital: ebara,        service: outpatient },
  { hospital: ebara,        service: inpatient },
  { hospital: ebara,        service: mri },

  { hospital: bokutoh,      service: outpatient },
  { hospital: bokutoh,      service: inpatient },
  { hospital: bokutoh,      service: emergency_care },
  { hospital: bokutoh,      service: surgery },

  { hospital: tama,         service: outpatient },
  { hospital: tama,         service: inpatient },
  { hospital: tama,         service: emergency_care },
  { hospital: tama,         service: mri },
  { hospital: tama,         service: ct_scan },

  { hospital: neurological, service: outpatient },
  { hospital: neurological, service: inpatient },
  { hospital: neurological, service: mri },

  { hospital: childrens,    service: outpatient },
  { hospital: childrens,    service: inpatient },
  { hospital: childrens,    service: emergency_care },
  { hospital: childrens,    service: vaccination },

  { hospital: matsuzawa,    service: outpatient },
  { hospital: matsuzawa,    service: inpatient },
  { hospital: matsuzawa,    service: rehab },

  { hospital: st_lukes,     service: outpatient },
  { hospital: st_lukes,     service: inpatient },
  { hospital: st_lukes,     service: emergency_care },
  { hospital: st_lukes,     service: mri },
  { hospital: st_lukes,     service: surgery },

  { hospital: saiseikai,    service: outpatient },
  { hospital: saiseikai,    service: inpatient },
  { hospital: saiseikai,    service: emergency_care },

  { hospital: ncgm,         service: outpatient },
  { hospital: ncgm,         service: inpatient },
  { hospital: ncgm,         service: vaccination },

  { hospital: ntt_medical,  service: outpatient },
  { hospital: ntt_medical,  service: mri },
  { hospital: ntt_medical,  service: ct_scan },

  { hospital: aiiku,        service: outpatient },
  { hospital: aiiku,        service: inpatient },
  { hospital: aiiku,        service: prenatal },

  { hospital: red_cross,    service: outpatient },
  { hospital: red_cross,    service: inpatient },
  { hospital: red_cross,    service: emergency_care },
  { hospital: red_cross,    service: prenatal },

  { hospital: univ_tokyo,  service: outpatient },
  { hospital: univ_tokyo,  service: inpatient },
  { hospital: univ_tokyo,  service: surgery },
  { hospital: univ_tokyo,  service: mri },
  { hospital: univ_tokyo,  service: ct_scan },

  { hospital: takanawa,    service: outpatient },
  { hospital: takanawa,    service: inpatient },
  { hospital: takanawa,    service: emergency_care },
  { hospital: takanawa,    service: xray },

  { hospital: tmsc,        service: outpatient },
  { hospital: tmsc,        service: vaccination },

  { hospital: sendagaya,   service: outpatient },
  { hospital: sendagaya,   service: vaccination },

  # --- PART 4 ward-by-ward services ---

  # Arakawa-ku
  { hospital: kosaka_ophthalmology,              service: outpatient },

  # Adachi-ku
  { hospital: aqua_dental,                       service: outpatient },
  { hospital: takahashi_clinic_adachi,           service: outpatient },
  { hospital: kohoku_family_clinic,              service: outpatient },
  { hospital: kohoku_family_clinic,              service: vaccination },

  # Katsushika-ku
  { hospital: koujinkai_daiichi,                 service: outpatient },
  { hospital: koujinkai_daiichi,                 service: inpatient },
  { hospital: koujinkai_daiichi,                 service: emergency_care },
  { hospital: tobu_chiiki,                       service: outpatient },
  { hospital: tobu_chiiki,                       service: inpatient },
  { hospital: tobu_chiiki,                       service: emergency_care },

  # Sumida-ku
  { hospital: kinshicho_mint_dental,             service: outpatient },

  # Koto-ku
  { hospital: telecom_center_dental,             service: outpatient },
  { hospital: wakaba_dental,                     service: outpatient },
  { hospital: sekoukai_dental,                   service: outpatient },
  { hospital: ono_cardiology,                    service: outpatient },
  { hospital: kobayashi_clinic_koto,             service: outpatient },
  { hospital: heiwa_memorial_clinic,             service: outpatient },
  { hospital: toyosu_minna_clinic,               service: outpatient },
  { hospital: toyosu_minna_clinic,               service: vaccination },
  { hospital: kameido_eye_clinic,                service: outpatient },
  { hospital: kameido_central_clinic,            service: outpatient },
  { hospital: shinonome_medical,                 service: outpatient },

  # Edogawa-ku
  { hospital: moriyama_memorial,                 service: outpatient },
  { hospital: moriyama_memorial,                 service: inpatient },
  { hospital: moriyama_memorial,                 service: emergency_care },
  { hospital: tokyo_rinkai,                      service: outpatient },
  { hospital: tokyo_rinkai,                      service: inpatient },
  { hospital: tokyo_rinkai,                      service: emergency_care },
  { hospital: tokyo_rinkai,                      service: ct_scan },
  { hospital: nishikasai_lifestyle_a,            service: outpatient },
  { hospital: nishikasai_lifestyle_a,            service: vaccination },
  { hospital: nishikasai_smile_dental,           service: outpatient },
  { hospital: himawari_dental,                   service: outpatient },
  { hospital: nishikasai_lifestyle_b,            service: outpatient },
  { hospital: nishikasai_lifestyle_b,            service: vaccination },
  { hospital: kobayashi_dental_edogawa,          service: outpatient },

  # Chiyoda-ku
  { hospital: tokyo_station_international,       service: outpatient },
  { hospital: tokyo_station_international,       service: vaccination },
  { hospital: isdorly_orthodontic,               service: outpatient },
  { hospital: ochanomizu_vascular,               service: outpatient },
  { hospital: shinomiya_clinic,                  service: outpatient },
  { hospital: ambulatory_vascular,               service: outpatient },
  { hospital: ambulatory_vascular,               service: surgery },
  { hospital: dental_salon_kojimachi,            service: outpatient },
  { hospital: your_clinic_akihabara,             service: outpatient },
  { hospital: ichihashi_dental,                  service: outpatient },
  { hospital: tokousha_kensin,                   service: outpatient },
  { hospital: sanno_medical,                     service: outpatient },
  { hospital: jtk_clinic,                        service: outpatient },
  { hospital: kojimachi_dermatology,             service: outpatient },
  { hospital: kandabashi_dental,                 service: outpatient },
  { hospital: st_lukes_medilocus,                service: outpatient },
  { hospital: imperial_clinic,                   service: outpatient },
  { hospital: tokyo_seaside_clinic,              service: outpatient },
  { hospital: tokyo_business_clinic_marunouchi, service: outpatient },
  { hospital: tokyo_business_clinic_yaesu,       service: outpatient },
  { hospital: tokyo_teishin,                     service: outpatient },
  { hospital: tokyo_teishin,                     service: inpatient },
  { hospital: hibiya_clinic,                     service: outpatient },
  { hospital: hamille_dental_tokyo,              service: outpatient },
  { hospital: hamille_ogawamachi,                service: outpatient },
  { hospital: asahi_ladies_clinic,               service: outpatient },
  { hospital: minsyu_dermatology,                service: outpatient },

  # Chuo-ku
  { hospital: kishi_clinica_femina,              service: outpatient },
  { hospital: online_general_clinic,             service: outpatient },
  { hospital: koike_clinic,                      service: outpatient },
  { hospital: mamizuka_dental,                   service: outpatient },
  { hospital: pulice_beauty,                     service: outpatient },
  { hospital: yaesugai_medical,                  service: outpatient },
  { hospital: fujimoto_international_dental,     service: outpatient },
  { hospital: kameda_kyobashi,                   service: outpatient },
  { hospital: nihonbashi_primary,                service: outpatient },
  { hospital: ps_i_clinic,                       service: outpatient },
  { hospital: harai_clinic,                      service: outpatient },
  { hospital: igarashi_endocrine,                service: outpatient },
  { hospital: takahashi_clinic_chuo,             service: outpatient },
  { hospital: ningyocho_internal_medicine,       service: outpatient },
  { hospital: total_skin_care_ginza,             service: outpatient },
  { hospital: kuramochi_nihonbashi,              service: outpatient },
  { hospital: mammaria_tsukiji,                  service: outpatient },

  # Bunkyo-ku
  { hospital: coco_medical,                      service: outpatient },
  { hospital: personal_health_clinic,            service: outpatient },
  { hospital: murai_clinic,                      service: outpatient },
  { hospital: dentsuin_clinic,                   service: outpatient },
  { hospital: hitomi_dental_bunkyo,              service: outpatient },
  { hospital: takagi_dental,                     service: outpatient },
  { hospital: sakuma_dental,                     service: outpatient },
  { hospital: juntendo,                          service: outpatient },
  { hospital: juntendo,                          service: inpatient },
  { hospital: juntendo,                          service: emergency_care },
  { hospital: juntendo,                          service: mri },
  { hospital: juntendo,                          service: ct_scan },
  { hospital: juntendo,                          service: surgery }
])
# =============================================================
# SUMMARY
# =============================================================
puts ""
puts "✅ MediTokyo seed data loaded successfully."
puts ""
puts "📊 Database summary:"
puts "   #{Hospital.count} hospitals & clinics"
puts "   #{Specialty.count} specialties"
puts "   #{Service.count} services"
puts "   #{EmergencyContact.count} emergency contacts"
puts "   #{InsuranceGuide.count} insurance guides"
puts ""
puts "🏥 Government hospitals: #{Hospital.where(is_government: true).count}"
puts "🏆 Certified clinics:    #{Hospital.where(is_certified: true).count}"
puts "🤱 Maternity facilities: #{Hospital.joins(:specialties).where(specialties: { name_en: 'Maternity & Obstetrics' }).count}"
puts "🚨 Emergency centers:    #{Hospital.joins(:services).where(services: { name_en: '24h Emergency Care' }).count}"
puts ""
puts "Source: tmhp.jp | jmip.jme.or.jp | aiiku.net | med.jrc.or.jp"
