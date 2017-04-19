module Api
  class ImagesController < ApplicationController
    def create
      CreateImageEndpoint.new(controller: self).call
    end

    def create_accepted
      head :accepted
    end
  end
end
