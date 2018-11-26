require_relative 'spec_helper'
require 'date'

describe 'JSON_weather' do

  before(:all) do
    @weather_data = Weather.new('weather_data.json')
  end

  # checking hash formats

  it "should be in hash format" do
    expect(@weather_data.json_file).to be_kind_of(Hash)
  end

  it "should have coord in hash format" do
    expect(@weather_data.get_coordinates).to be_kind_of(Hash)
  end

  it "should have weather in hash format" do
    expect(@weather_data.get_weather).to be_kind_of(Hash)
  end

  it "should have main in hash format" do
    expect(@weather_data.get_main).to be_kind_of(Hash)
  end

  it "should have wind in hash format" do
    expect(@weather_data.get_wind).to be_kind_of(Hash)
  end

  it "should have clouds in hash format" do
    expect(@weather_data.get_clouds).to be_kind_of(Hash)
  end

  it "should have sys in hash format" do
    expect(@weather_data.get_sys).to be_kind_of(Hash)
  end

  context 'coordinates' do

    it "should contain 2 entries" do
      expect(@weather_data.get_coordinates.length).to eq 2
    end

    it "should have longitude and latitude in float format" do
      expect(@weather_data.get_coordinates_longitude).to be_kind_of(Float)
      expect(@weather_data.get_coordinates_lattitude).to be_kind_of(Float)
    end

    it "should have longitude and latitude in the correct valid range" do
      expect(@weather_data.get_coordinates_longitude).to be_between(-180, 180).inclusive
      expect(@weather_data.get_coordinates_lattitude).to be_between(-90, 90).inclusive
    end

  end

  context 'weather' do

    it "should contain 4 entries" do
      expect(@weather_data.get_weather.length).to eq 4
    end

    it "should have id as an integer" do
      expect(@weather_data.get_weather_id).to be_kind_of(Integer)
    end

    it "should have main as a string, capitalized and below 255 characters" do
      expect(@weather_data.get_weather_main).to be_kind_of(String)
      expect(@weather_data.get_weather_main).to eq @weather_data.get_weather_main.capitalize
      expect(@weather_data.get_weather_main.length).to be <= 255
    end

    it "should have description as a string" do
      expect(@weather_data.get_weather_description).to be_kind_of(String)
    end

    it "should have icon as a string" do
      expect(@weather_data.get_weather_icon).to be_kind_of(String)
    end

  end

    # could apply other test on icon format, but not sure what icon should look like

  context 'base' do

    it "should be a string and below 255 characters" do
      expect(@weather_data.get_base).to be_kind_of(String)
      expect(@weather_data.get_base.length).to be <= 255
    end

  end

  context 'main' do

    it "should contain 5 items" do
      expect(@weather_data.get_main.length).to eq 5
    end

    it "should have temperatures as floats in reasonable ranges" do
      expect(@weather_data.get_main_temp).to be_kind_of(Float)
      expect(@weather_data.get_main_temp).to be_between(200, 400).inclusive
      expect(@weather_data.get_main_temp_min).to be_kind_of(Float)
      expect(@weather_data.get_main_temp_min).to be_between(200, 400).inclusive
      expect(@weather_data.get_main_temp_max).to be_kind_of(Float)
      expect(@weather_data.get_main_temp_max).to be_between(200, 400).inclusive
    end

    it "should have a temperature between the min and max" do
      expect(@weather_data.get_main_temp).to be_between(@weather_data.get_main_temp_min, @weather_data.get_main_temp_max)
    end

    it "should have a pressure value as an integer value in a reasonable range" do
      expect(@weather_data.get_main_pressure).to be_kind_of(Integer)
      expect(@weather_data.get_main_temp).to be_between(200, 1200).inclusive
    end

    it "should have humidity as an integer not above 100 (assuming this is relative humidity)" do
      expect(@weather_data.get_main_humidity).to be_kind_of(Integer)
      expect(@weather_data.get_main_humidity).to be_between(0, 100).inclusive
    end

  end

  context 'visibility' do

    it "should be an integer" do
      expect(@weather_data.get_visibility).to be_kind_of(Integer)
    end

    # not sure how this value should look

  end

  context 'wind' do

    it "should contain 2 items" do
      expect(@weather_data.get_wind.length).to eq 2
    end

    it "should have a wind speed in float format and below 300mph (record high being 231mph)" do
      expect(@weather_data.get_wind_speed).to be_kind_of(Float)
      expect(@weather_data.get_wind_speed).to be <= 300
    end

    it "should have degrees in integer format between 0 and 360" do
      expect(@weather_data.get_wind_deg).to be_kind_of(Integer)
      expect(@weather_data.get_wind_deg).to be_between(0, 360)
    end

  end

  context 'clouds' do

    # should there always be 'all'
    # could there be more keys here

  end

  context 'dt' do

    it "should be an integer" do
      expect(@weather_data.get_dt).to be_kind_of(Integer)
    end

    it "should be between the sunrise and sunset values" do
      expect(@weather_data.get_dt).to be_between(@weather_data.get_sys_sunrise, @weather_data.get_sys_sunset).inclusive
    end

  end

  context 'sys' do

    it "should contain 6 items" do
      expect(@weather_data.get_sys.length).to eq 6
    end

    it "should have a type in integer format" do
      expect(@weather_data.get_sys_type).to be_kind_of(Integer)
      # not sure if a range should apply (maybe non-negative)
    end

    it "should have an id in integer format and be above zero" do
      expect(@weather_data.get_sys_id).to be_kind_of(Integer)
      expect(@weather_data.get_sys_id).to be > 0
    end

    it "should have a message in float format" do
      expect(@weather_data.get_sys_message).to be_kind_of(Float)
      # not sure of a range (maybe non-negative)
    end

    it "should have a counrty that is in string format, uppercase and 3 characters max" do
      expect(@weather_data.get_sys_country).to be_kind_of(String)
      expect(@weather_data.get_sys_country.length).to be <= 3
      expect(@weather_data.get_sys_country).to eq @weather_data.get_sys_country.upcase
    end

    it "should have a sunrise and sunset value that is in integer format" do
      expect(@weather_data.get_sys_sunrise).to be_kind_of(Integer)
      expect(@weather_data.get_sys_sunset).to be_kind_of(Integer)
    end

    it "should have a sunrise and sunset value that is below the current unix time" do
      expect(@weather_data.get_sys_sunrise).to be <= DateTime.now.to_time.to_i
      expect(@weather_data.get_sys_sunset).to be <= DateTime.now.to_time.to_i
    end

  end

  context 'id' do

    it "should be an integer and be above zero" do
      expect(@weather_data.get_id).to be_kind_of(Integer)
      expect(@weather_data.get_id).to be > 0
    end

  end

  context 'name' do

    it "should be a string, capitalized and below 255 characters" do
      expect(@weather_data.get_name).to be_kind_of(String)
      expect(@weather_data.get_name).to eq @weather_data.get_name.capitalize
      expect(@weather_data.get_name.length).to be <= 255
    end

  end

  context 'cod' do

    it "should be an integer" do
      expect(@weather_data.get_cod).to be_kind_of(Integer)
      # not sure what cod is and so have no range to test (maybe non-negative)
    end

  end

end
