Geocoder.configure(
  lookup: :nominatim,
  nominatim_one_result: true,
  units: :km,
  timeout: 10,
  use_https: true,
  http_headers: { "User-Agent" => "MediTokyo/1.0 (medical info app Tokyo)" }
)
