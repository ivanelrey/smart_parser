require 'tempfile'

RSpec.describe Application do
  let(:app) { described_class.new }
  let(:log_file) { Tempfile.new('webserver.log', './spec/tmp/') }

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

    context 'when log_file is empty' do
      let(:expected_output) { "Most visited pages:\nMost uniq visits:\n" }

      it 'outputs correct message' do
        expect { app.run(log_file) }.to output(expected_output).to_stdout
      end
    end
  end
end
