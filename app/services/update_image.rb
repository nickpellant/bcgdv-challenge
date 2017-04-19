class UpdateImage
  def initialize(image:, params:)
    @image = image
    @params = params
  end

  def call
    image_form = ImageForm.new(@image)

    if image_form.validate(@params)
      image_form.save
      @image
    else
      image_form.errors
    end
  end
end
