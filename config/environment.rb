# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Wardround::Application.initialize!

#Set default date format
Date::DATE_FORMATS.merge!(:default => "%d/%m/%y")



