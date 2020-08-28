RSpec.describe Application do
  let(:app) { described_class.new }

  describe '#run' do
    context 'without file name' do
      it 'raises an argument error with correct message' do
        expect { app.run(nil) }.to raise_error(ArgumentError, 'Please provide a file name.')
      end
    end
  end
end
