RSpec.describe LogFile::Validators::WebPageValidator do
  let(:validator) { described_class.new }
  let(:line) { LogFile::Line.new("#{web_page} 111.111.111.111") }

  describe '#valid?' do
    context 'with valid web_page string' do
      let(:web_page) { '/admin/users/5/edit' }

      it 'returns true' do
        expect(validator.valid?(line)).to be(true)
      end
    end

    context 'with invalid web_page string' do
      let(:web_page) { 'invalid_web_page' }

      it 'returns false' do
        expect(validator.valid?(line)).to be(false)
      end
    end
  end
end
