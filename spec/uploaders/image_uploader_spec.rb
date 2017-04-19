require 'rails_helper'

RSpec.describe ImageUploader, type: :uploader do
  subject(:image_uploader) { described_class.new }

  let(:image_file_path) do
    Rails.root.join('spec', 'support', 'uploader_image.png')
  end

  describe '#store!' do
    subject(:store) do
      File.open(image_file_path) { |file| image_uploader.store!(file) }
    end

    before(:example) do
      described_class.enable_processing = true
      store
    end

    after(:example) do
      described_class.enable_processing = false
      image_uploader.remove!
    end

    it 'it stores the file that was passed' do
      expect(image_uploader.current_path).to(
        eql('/prog_image/public/uploads/uploader_image.png')
      )
    end
  end
end
