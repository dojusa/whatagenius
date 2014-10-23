# encoding: utf-8

class PostUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick 

  process :resize_to_fit => [640, 480]
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
end
