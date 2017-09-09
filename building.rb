#!/usr/bin/env ruby
#
# building.rb
# SWN Building Generator
require 'yaml'

class Building
    attr_reader :type
    def initialize
        yaml = YAML.load(File.read('tables/building_components/building_types.yaml'))
        @type = yaml['building_type'].sample
        puts @type
        @no_com = yaml[@type]['num_common'].sample
        @no_unc = yaml[@type]['num_uncommon'].sample
        @no_rar = yaml[@type]['num_rare'].sample

    end

    def to_s
        yaml = YAML.load(File.read('tables/building_components/building_types.yaml'))
        
        @no_com.times {Building_room.new(yaml[@type]['common_rooms'].sample.to_str)}
        @no_unc.times {Building_room.new(yaml[@type]['uncommon_rooms'].sample.to_str)}
        @no_rar.times {Building_room.new(yaml[@type]['rare_rooms'].sample.to_str)}

        string = ""
        # @no_com.times {string = string + yaml[@type]['uncommon_rooms'].sample.to_str + "\n"}
        # @no_unc.times {string = string + yaml[@type]['uncommon_rooms'].sample.to_str + "\n"}
        # @no_rar.times {string = string + yaml[@type]['uncommon_rooms'].sample.to_str + "\n"}
        return string
    end
end

class Building_room
    def initialize(type)
        rooms = YAML.load(File.read('tables/building_components/room_types.yaml'))
        @room_details = rooms[type]
        # puts type
        puts @room_details['size'].sample + ' ' + @room_details['name']
        # puts @room_details['description']
        @room_details['prop_number'].times {puts '   ' + @room_details['props'].sample}
        puts '-------------------------------'
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