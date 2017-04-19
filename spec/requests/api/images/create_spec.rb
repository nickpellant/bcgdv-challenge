require 'rails_helper'

RSpec.describe 'Create Image', type: :request do
  subject(:perform_request) { post(api_images_url) }

  before(:example) { perform_request }

  it 'responds with an accepted status' do
    expect(response).to have_http_status(:accepted)
  end
end
