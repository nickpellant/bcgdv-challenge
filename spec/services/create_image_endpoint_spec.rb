require 'spec_helper'

RSpec.describe CreateImageEndpoint, type: :service do
  subject(:create_image_endpoint) do
    described_class.new(controller: controller)
  end

  describe '#call' do
    subject(:call) { create_image_endpoint.call }

    before(:example) { call }

    let(:controller) { instance_spy('Api::ImagesController') }

    it 'responds with an accepted status' do
      expect(controller).to have_received(:create_accepted)
    end
  end
end
