RSpec.describe LogFile::Validators::IpValidator do
  let(:validator) { described_class.new }
  let(:line) { LogFile::Line.new("/admin #{ip}") }

  describe '#valid?' do
    context 'with valid ip string' do
      let(:ip) { '111.111.111.111' }

      it 'returns true' do
        expect(validator.valid?(line)).to be(true)
      end
    end

    context 'with invalid ip string' do
      let(:ip) { 'invalid_ip' }

      it 'returns false' do
        expect(validator.valid?(line)).to be(false)
      end
    end
  end
end
