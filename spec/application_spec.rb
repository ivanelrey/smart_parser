RSpec.describe Application do
  let(:app) { described_class.new }

  describe '#run' do
    context 'without file_name' do
      it 'raises an argument error with correct message' do
        expect { app.run(nil) }.to raise_error(ArgumentError, 'Please provide a file name.')
      end
    end

    context 'when file with file_name doesn\'t exist' do
      let(:ivalid_file_name) { 'not_existing_file.log' }

      it 'raises an argument error with correct message' do
        expect { app.run(ivalid_file_name) }.to raise_error(ArgumentError, 'Please provide an existing file.')
      end
    end
  end
end
