require 'ostruct'

module Calibration
  Config = OpenStruct.new

  begin
    YAML::load_file(config_file = Rails.root.join('config', 'secrets.yml'))[Rails.env].each do |key, value|
      value = value.is_a?(Hash) ? OpenStruct.new(value) : value
      Config.public_send("#{key}=", value)
    end
  rescue
    puts "Config file is missing!"
  end
end
