Cloudinary.config do |config|
    config.cloud_name = Figaro.env.cloudinary_cloud
    config.api_key = Figaro.env.cloudinary_key
    config.api_secret = Figaro.env.cloudinary_secret
end
