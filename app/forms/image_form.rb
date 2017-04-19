class ImageForm < Reform::Form
  property :file
  validates :file, presence: true
end
