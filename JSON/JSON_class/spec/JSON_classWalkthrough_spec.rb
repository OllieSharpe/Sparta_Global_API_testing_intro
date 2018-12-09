require_relative 'spec_helper'

describe 'JSON_classWalkthrough' do

  before(:all) do
    @exchange_rates = ParseJson.new('json_exchange_rates.json')
  end

  it "should be in hash format" do
    expect(@exchange_rates.json_file).to be_kind_of(Hash)
  end

  it "should be in euros and be a string" do
    expect(@exchange_rates.get_base).to eq "EUR"
    expect(@exchange_rates.get_base).to be_kind_of(String)
  end

  it "should have a date in the correct format" do
    @exchange_rates.get_date
    expect(@exchange_rates.valid_date).to be true
  end

  it "should return the date in string format" do
    @exchange_rates.get_date
    expect(@exchange_rates.year).to be_kind_of(String)
    expect(@exchange_rates.month).to be_kind_of(String)
    expect(@exchange_rates.day).to be_kind_of(String)
  end

  it "should return the date gap between today and the date from the API" do
    expect(@exchange_rates.recency).to be < 730
  end

  it "should have all float values inside rates and greaer than zero" do
    @exchange_rates.get_rates.each do |key, values|
      expect(@exchange_rates.float_int_check(values)).to be true
      expect(values).to be > 0
    end
  end

  it "should have 31 keys and values in rates" do
    expect(@exchange_rates.get_rates.keys.length).to be 31
    expect(@exchange_rates.get_rates.values.length).to be 31
  end

  it "should have keys that are 3 Uppercase characters" do
    @exchange_rates.get_rates.each do |key, values|
      expect(key.length).to be 3
      expect(key).to eq key.upcase
    end
  end

end
