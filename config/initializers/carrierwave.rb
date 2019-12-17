require 'carrierwave/mongoid'

CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:s3_key],
      aws_secret_access_key: Rails.application.credentials.aws[:s3_secret],
      region: Rails.application.credentials.aws[:s3_region]
  }
  config.fog_directory = Rails.application.credentials.aws[:s3_bucket_name]
  config.storage = :grid_fs
  config.root = Rails.root.join('public')
  config.cache_dir = 'uploads'
end