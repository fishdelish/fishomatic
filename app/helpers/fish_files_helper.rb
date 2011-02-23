module FishFilesHelper
  def fish_file_fields
    [
      {:field_name => ".date", :field_label => "Observation date"},
      {:field_name => ".remark", :field_label => "Remarks"},
      {:field_name => ".FAO_area", :field_label => "Area"},
      {:field_name => ".country", :field_label => "Country"},
      {:field_name => ".locality", :field_label => "Locality"},
      {:field_name => ".lat_lng", :field_label => "Location (lat, long)"},
      {:field_name => ".accuracy", :field_label => "Location accuracy"},
      {:field_name => ".abundance", :field_label => "Species abundance"},
      {:field_name => ".species_type", :field_label => "Species type"},
      {:field_name => ".gear", :field_label => "Gear used"},
      {:field_name => ".temperature", :field_label => "Temperature"},
      {:field_name => ".day_time", :field_label => "Day time"},
      {:field_name => ".life_stage", :field_label => "Life stage"},
      {:field_name => ".length", :field_label => "Fish length"},
      {:field_name => ".salinity", :field_label => "Water salinity"}
    ]
  end
end
