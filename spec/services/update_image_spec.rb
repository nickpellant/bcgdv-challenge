require 'rails_helper'

RSpec.describe UpdateImage, type: :service do
  subject(:update_image) { described_class.new(image: image, params: params) }

  let(:image) { Image.new }
  let(:params) { { file: file } }

  let(:file_path) { Rails.root.join('spec', 'support', 'uploader_image.png') }

  describe '#call' do
    subject(:call) { update_image.call }

    before(:example) { call }

    context 'with a new Image' do
      context 'when image form is valid' do
        let(:file) { File.open(file_path) }

        it 'saves and returns the image' do
          is_expected.to eql(image)
          expect(image).to be_persisted
        end
      end

      context 'when image form is invalid' do
        let(:file) { nil }

        it 'returns the image form errors' do
          is_expected.to have_attributes(messages: { file: ["can't be blank"] })
          expect(image).not_to be_persisted
        end
      end
    end
  end
end
