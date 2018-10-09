class PictureUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick
  process resize_to_fill: [250, 250]
  process :convert => 'png'
  process :tags => ['product_picture']

  def public_id
    return model.name
  end

end
