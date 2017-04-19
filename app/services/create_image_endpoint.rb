class CreateImageEndpoint
  def initialize(controller:)
    @controller = controller
  end

  def call
    image_or_errors = UpdateImage.new(
      image: Image.new, params: @controller.params
    ).call

    if image_or_errors.is_a?(Image)
      @controller.create_accepted(image_or_errors)
    else
      @controller.create_bad_request(image_or_errors)
    end
  end
end
