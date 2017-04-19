module Api
  class ImagesController < ApplicationController
    def create
      CreateImageEndpoint.new(controller: self).call
    end

    def create_accepted(_image)
      head :accepted
    end

    def create_bad_request(errors)
      render_json_error(
        code: :parameter_missing,
        status: :bad_request,
        options: { details: errors.messages }
      )
    end
  end
end
