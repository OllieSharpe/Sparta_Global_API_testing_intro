require 'json'

class Weather

  attr_accessor :json_file

  def initialize(json_file)
    @json_file = JSON.parse(File.read(json_file))
  end

  def get_coordinates
    @json_file['coord']
  end

  def get_coordinates_longitude
    @json_file['coord']['lon']
  end

  def get_coordinates_lattitude
    @json_file['coord']['lat']
  end

  def get_weather
    @json_file['weather'][0]
  end

  def get_weather_id
    @json_file['weather'][0]['id']
  end

  def get_weather_main
    @json_file['weather'][0]['main']
  end

  def get_weather_description
    @json_file['weather'][0]['description']
  end

  def get_weather_icon
    @json_file['weather'][0]['icon']
  end

  def get_base
    @json_file['base']
  end

  def get_main
    @json_file['main']
  end

  def get_main_temp
    @json_file['main']['temp']
  end

  def get_main_pressure
    @json_file['main']['pressure']
  end

  def get_main_humidity
    @json_file['main']['humidity']
  end

  def get_main_temp_min
    @json_file['main']['temp_min']
  end

  def get_main_temp_max
    @json_file['main']['temp_max']
  end

  def get_visibility
    @json_file['visibility']
  end

  def get_wind
    @json_file['wind']
  end

  def get_wind_speed
    @json_file['wind']['speed']
  end

  def get_wind_deg
    @json_file['wind']['deg']
  end

  def get_clouds
    @json_file['clouds']
  end

  def get_clouds_all
    @json_file['clouds']['all']
  end

  def get_dt
    @json_file['dt']
  end

  def get_sys
    @json_file['sys']
  end

  def get_sys_type
    @json_file['sys']['type']
  end

  def get_sys_id
    @json_file['sys']['id']
  end

  def get_sys_message
    @json_file['sys']['message']
  end

  def get_sys_country
    @json_file['sys']['country']
  end

  def get_sys_sunrise
    @json_file['sys']['sunrise']
  end

  def get_sys_sunset
    @json_file['sys']['sunset']
  end

  def get_id
    @json_file['id']
  end

  def get_name
    @json_file['name']
  end

  def get_cod
    @json_file['cod']
  end

    DateTime.now.to_time.to_i


end
