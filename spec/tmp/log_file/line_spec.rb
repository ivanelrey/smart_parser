RSpec.describe LogFile::Line do
  let(:web_page) { '/first_page' }
  let(:ip) { '111.111.111.111' }
  let(:valid_line_string) { "#{web_page} #{ip}" }

  describe '#initialize' do
    context 'with valid line string' do
      it 'doesn\'t raise error' do
        expect { described_class.new(valid_line_string) }.not_to raise_error
      end
    end

    context 'with unparsable line string' do
      let(:unparsable_line_string) { 'invalid_line' }

      it 'raises UnparsableLineError' do
        expect { described_class.new(unparsable_line_string) }.to raise_error(LogFile::UnparsableLineError)
      end
    end
  end

  describe '#web_page_string' do
    let(:line) { described_class.new(valid_line_string) }

    it 'returns web_page as a string' do
      expect(line.web_page_string).to eq(web_page)
    end
  end

  describe '#ip_string' do
    let(:line) { described_class.new(valid_line_string) }

    it 'returns ip as a string' do
      expect(line.ip_string).to eq(ip)
    end
  end
end
