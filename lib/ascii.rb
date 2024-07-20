# frozen_string_literal: true

require 'mini_magick'

class ASCII
  IMAGE_WIDTH = 200
  GRAY = 'Gray'
  ASCII_CHARS = ['@', '#', 'S', '%', '?', '*', '+', ';', ':', ',', '.'].freeze

  attr_reader :image, :image_path, :result

  def initialize(image_path)
    @image_path = image_path
  end

  def create
    @image = MiniMagick::Image.open(@image_path)
                              .resize("#{IMAGE_WIDTH}x")
                              .colorspace(GRAY)

    @result = pixels.each_slice(IMAGE_WIDTH).map(&:join).join("\n")
    generate_txt_file
    puts 'ASCII Success'
  rescue MiniMagick::Error
    puts "#{image_path} Not a valid image (.png, .jpg, .jpeg)"
  rescue StandardError
    puts 'Unable to handle image'
  end

  private

  def pixels
    @pixels ||= image.get_pixels.flatten.each_slice(3).map do |pixel|
      ASCII_CHARS[pixel[0] / 25]
    end
  end

  def generate_txt_file
    File.open("results/#{filename}.txt", 'w') { |file| file.write(result) }
  end

  def filename
    Pathname.new(image_path).basename.to_s
  end
end
