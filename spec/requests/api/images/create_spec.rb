require 'rails_helper'

RSpec.describe 'Create Image', type: :request do
  subject(:perform_request) { post(api_images_url, params: params) }

  let(:image_file_path) do
    Rails.root.join('spec', 'support', 'uploader_image.png')
  end

  context 'when provided with a valid image file' do
    let(:params) { { file: fixture_file_upload(image_file_path, 'image/png') } }

    let(:created_image) { Image.last }

    it 'creates the image record and responds with an accepted status' do
      expect { perform_request }.to(change { Image.count })

      expect(created_image.file.file).to be_nil
      expect(created_image.file_tmp).to include('uploader_image.png')

      expect(CarrierWave::Workers::StoreAsset.jobs.size).to eql(1)

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
