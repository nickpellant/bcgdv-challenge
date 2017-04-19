require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe 'Create Image', type: :request do
  include CarrierWave::Test::Matchers

  subject(:perform_request) { post(api_images_url, params: params) }

  let(:image_file_path) do
    Rails.root.join('spec', 'support', 'uploader_image.png')
  end

  context 'when provided with a valid image file' do
    let(:params) { { file: fixture_file_upload(image_file_path, 'image/png') } }

    let(:created_image) { Image.last }

    it 'creates the image and responds with an accepted status' do
      expect { perform_request }.to(change { Image.count })

      expect(created_image.file).to be_format('png')
      expect(created_image.file).to have_dimensions(150, 150)

      expect(response).to have_http_status(:accepted)
    end
  end

  context 'when no image file is provided' do
    let(:params) { {} }

    let(:response_json) do
      {
        errors: [
          {
            title: I18n.translate(
              'error_codes.parameter_missing.message'
            ),
            status: 'bad_request',
            details: {
              file: ["can't be blank"]
            }
          }
        ]
      }.to_json
    end

    it 'fails and responds with a bad request status' do
      expect { perform_request }.not_to(change { Image.count })
      expect(response).to have_http_status(:bad_request)
      expect(response.body).to eql(response_json)
    end
  end
end
