class CardPicUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "public/images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [360, 360]

  version :thumb do
    process resize_to_fill: [100, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
