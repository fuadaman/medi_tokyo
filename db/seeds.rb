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
  { hospital: sendagaya,   specialty: pediatrics }
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
  { hospital: sendagaya,   service: vaccination }
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
