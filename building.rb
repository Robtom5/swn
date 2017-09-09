#!/usr/bin/env ruby
#
# building.rb
# SWN Building Generator
require 'yaml'

class Building
    attr_reader :type
    def initialize
        yaml = YAML.load(File.read('tables/building_components/building_types.yaml'))
        @type = yaml['building_type'].sample.to_str

    end

    def to_s
        yaml = YAML.load(File.read('tables/building_components/building_types.yaml'))
        Building_room.new(yaml[@type+'_rooms'].sample.to_str)

        string = ""
        # [4,5].sample.times {string = string + yaml[@type+'_rooms'].sample.to_str + "\n"}
        return string
    end
end

class Building_room
    def initialize(type)
        rooms = YAML.load(File.read('tables/building_components/room_types.yaml'))
        @room_details = rooms[type]
        # puts type
        puts @room_details['name']
        puts @room_details['size'].sample
        puts @room_details['description']
        @room_details['prop_number'].times {puts @room_details['props'].sample}
    end
end

if __FILE__ == $0
  Integer(ARGV.shift || 1).times do |e|
    puts ''unless e.zero?
    puts '----------------------+-+-+----------------------'
    puts Building.new
    puts '----------------------+-+-+----------------------'
  end
end