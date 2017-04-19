class CreateImageEndpoint
  def initialize(controller:)
    @controller = controller
  end

  def call
    @controller.create_accepted
  end
end
