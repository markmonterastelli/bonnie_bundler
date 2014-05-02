source "http://rubygems.org"
gemspec

#gem 'health-data-standards', '3.4.4'
gem 'health-data-standards', :git => 'https://github.com/projectcypress/health-data-standards.git', :branch => 'simple_xml_parser'
gem 'quality-measure-engine', '3.0.0'
gem 'hqmf2js', '1.3.0'
gem 'hquery-patient-api', '1.0.4'
gem 'simplexml_parser', :git => 'https://github.com/projecttacoma/simplexml_parser.git', :branch => 'master'

#gem 'health-data-standards', :path => '../health-data-standards'
#gem 'quality-measure-engine', :path => '../quality-measure-engine'
#gem 'hqmf2js', :path => '../health-data-standards'
#gem 'hquery-patient-api', :path => '../patientapi'
#gem 'simplexml_parser', :path => '../simplexml_parser'

gem 'rails', '3.2.14'
gem 'rake'
gem 'pry'
gem 'tilt'
gem 'coffee-script'
gem 'sprockets'
gem "therubyracer", :require => 'v8'
gem 'mongoid'
gem 'rubyzip', '< 1.0.0'

# needed for parsing value sets (we need to use roo rather than rubyxl because the value sets are in xls rather than xlsx)
gem 'roo'

group :test do
  gem 'simplecov', :require => false

  gem 'minitest', "~> 4.0"
  gem 'turn', :require => false
  gem 'awesome_print', :require => 'ap'
end

