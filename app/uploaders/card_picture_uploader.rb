class CardPictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fill: [360, 360]

  version :thumb do
    process resize_to_fill: [175, 175]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
