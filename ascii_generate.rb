# frozen_string_literal: true

require_relative 'lib/ascii'

if ARGV.length.positive?
  image_path = ARGV[0]

  ASCII.new(image_path).create
else
  puts 'there are no arguments'
end
