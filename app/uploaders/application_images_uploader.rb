class ApplicationImagesUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  def store_dir
    "system/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def extension_white_list
    %w(jpg jpeg gif png pdf tiff tif eps bmp ps)
  end

  private

    def rgbify
      unless Rails.env.test?
        begin
          manipulate! do |img|  
            img.colorspace "sRGB"
            img
          end
        end
      end
    end

    def efficient_conversion(width, height)
      manipulate! do |img|
        img.format("jpg") do |c|
          c.trim
          c.resize      "#{width}x#{height}>"
          c.resize      "#{width}x#{height}<"
        end
        img
      end
    end

end
