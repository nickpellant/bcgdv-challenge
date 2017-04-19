require 'spec_helper'

RSpec.describe CreateImageEndpoint, type: :service do
  subject(:create_image_endpoint) do
    described_class.new(controller: controller)
  end

  describe '#call' do
    subject(:call) { create_image_endpoint.call }

    before(:example) { call }

    let(:controller) { instance_spy('Api::ImagesController', params: params) }
    let(:params) { ActionController::Parameters.new(file: file) }

    context 'when image file is valid' do
      let(:file_path) do
        Rails.root.join('spec', 'support', 'uploader_image.png')
      end
      let(:file) { File.open(file_path) }

      it 'responds with an accepted status' do
        expect(controller).to have_received(:create_accepted)
      end
    end

    context 'when image file is invalid' do
      let(:file) { nil }

      it 'responds with an unprocessable_entity status' do
        expect(controller).to have_received(:create_bad_request)
      end
    end
  end
end
