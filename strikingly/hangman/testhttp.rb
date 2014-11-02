require 'rubygems'
require 'json'
require 'net/http'

class Crunchbase_Company

  @record = nil

  def initialize( company )

    url = "http://strikingly-interview-test.herokuapp.com/guess/process"

    resp = Net::HTTP.get_response(URI.parse(url))

    @record = JSON.parse(resp.body)

  end

  def founded_year
    return @record['founded_year']
  end

  def num_employees
    return @record['number_of_employees']
  end

  def company_type
    return @record['category_code']
  end

  def people

    employees = Hash.new

    relationships = @record['relationships']

    if !relationships.nil?

      relationships.each do | person |
        if person['is_past'] == false then
          permalink = person['person']['permalink']
          title = person['title']
          employees[permalink] = title
        end
      end

    end

    return employees

  end

end