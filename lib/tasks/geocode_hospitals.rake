namespace :hospitals do
  desc "Geocode all hospitals using address_en"
  task geocode: :environment do
    puts "Starting geocoding for #{Hospital.count} hospitals..."
    puts "---"

    Hospital.all.each do |hospital|
      query = "#{hospital.name_en}, #{hospital.ward}, Tokyo, Japan"

      puts "Geocoding: #{hospital.name_en}"
      puts "Query: #{query}"

      result = Geocoder.search(query).first

      if result
        old_lat = hospital.latitude
        old_lng = hospital.longitude
        hospital.update!(
          latitude: result.latitude.round(6),
          longitude: result.longitude.round(6)
        )
        puts "✅ Updated: #{old_lat}, #{old_lng} → #{result.latitude.round(6)}, #{result.longitude.round(6)}"
      else
        puts "❌ Trying Japanese name..."
        result = Geocoder.search("#{hospital.name_jp}, Tokyo, Japan").first

        if result
          hospital.update!(
            latitude: result.latitude.round(6),
            longitude: result.longitude.round(6)
          )
          puts "✅ Updated with JP: #{result.latitude.round(6)}, #{result.longitude.round(6)}"
        else
          puts "❌ Could not geocode: #{hospital.name_en} — skipping"
        end
      end

      puts "---"
      sleep 1.2
    end

    puts "✅ Done! All hospitals processed."
  end
end
