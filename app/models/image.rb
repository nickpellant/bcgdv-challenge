class Image < ApplicationRecord
  mount_uploader :file, ImageUploader
  store_in_background :file
end
