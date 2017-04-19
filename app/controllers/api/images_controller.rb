module Api
  class ImagesController < ApplicationController
    def create
      create_accepted
    end

    def create_accepted
      head :accepted
    end
  end
end
