require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe ImageUploader, type: :uploader do
  include CarrierWave::Test::Matchers

  subject(:image_uploader) { described_class.new }

  let(:image_file_path) do
    Rails.root.join('spec', 'support', 'uploader_image.png')
  end

  describe '#store!' do
    subject(:store) do
      File.open(image_file_path) { |file| image_uploader.store!(file) }
    end

    before(:example) { store }

    after(:example) { image_uploader.remove! }

    it 'it stores the file that was passed' do
      expect(image_uploader).to be_format('png')
      expect(image_uploader).to have_dimensions(150, 150)
    end
  end
end
