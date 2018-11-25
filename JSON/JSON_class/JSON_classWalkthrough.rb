require 'json'
require 'date'

class ParseJson

  attr_accessor :json_file, :year, :month, :day

  def initialize(json_file)
    @json_file = JSON.parse(File.read(json_file))
    @day = 0
    @month = 0
    @year = 0
  end

  def get_date
    @year, @month, @day = @json_file['date'].split '-'
  end

  def valid_date
    Date.valid_date? @year.to_i, @month.to_i, @day.to_i
  end

  def recency
    current_date = Time.now.to_date
    date_from_API = Date.parse(@json_file['date'])
    diff = (current_date - date_from_API).to_i
  end

  def float_int_check(number)
    if (number.is_a? Integer or number.is_a? Float)
      return true
    end
  end

  def get_rates
    @json_file['rates']
  end

  def get_base
    @json_file['base']
  end

end
