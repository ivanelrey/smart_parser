require 'tempfile'
require 'pry'

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

    context 'when log_file contains invalid lines' do
      let(:expected_output) { "Unparsable line detected on line: 2\n" }

      before do
        log_file.write("/home 111.111.111.111\n")
        log_file.write('unparsable_line')
        log_file.rewind
      end

      after { log_file.unlink }

      it 'outputs error message and exits Application' do
        expect { app.run(log_file) }.to output(expected_output).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'when log_file contains invalid web_page' do
      let(:expected_output) { "Invalid WebPage or IP detected on line: 2\n" }

      before do
        log_file.write("/home 111.111.111.111\n")
        log_file.write('invalid_web_page 222.222.222.222')
        log_file.rewind
      end

      after { log_file.unlink }

      it 'outputs error message and exits Application' do
        expect { app.run(log_file) }.to output(expected_output).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'when log_file contains invalid IP' do
      let(:expected_output) { "Invalid WebPage or IP detected on line: 2\n" }

      before do
        log_file.write("/home 111.111.111.111\n")
        log_file.write('/index invalid_ip')
        log_file.rewind
      end

      after { log_file.unlink }

      it 'outputs error message and exits Application' do
        expect { app.run(log_file) }.to output(expected_output).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'when log_file contains one visit' do
      let(:expected_output) { "Most visited pages:\n/home -> 1\nMost uniq visits:\n/home -> 1\n" }

      before do
        log_file.write("/home 111.111.111.111\n")
        log_file.rewind
      end

      after { log_file.unlink }

      it 'outputs correct results' do
        expect { app.run(log_file) }.to output(expected_output).to_stdout
      end
    end

    context 'when log_file contains multiple visits' do
      let(:expected_output) do
        "Most visited pages:\n"\
        "/home -> 4\n"\
        "/about -> 2\n"\
        "/admin -> 1\n"\
        "Most uniq visits:\n"\
        "/home -> 3\n"\
        "/about -> 2\n"\
        "/admin -> 1\n"
      end

      before do
        log_file.write("/home 111.111.111.111\n")
        log_file.write("/admin 333.333.333.333\n")
        log_file.write("/about 111.111.111.111\n")
        log_file.write("/home 222.222.222.222\n")
        log_file.write("/home 111.111.111.111\n")
        log_file.write("/about 222.222.222.222\n")
        log_file.write("/home 333.333.333.333\n")
        log_file.rewind
      end

      after { log_file.unlink }

      it 'outputs correct results ordered correctly' do
        expect { app.run(log_file) }.to output(expected_output).to_stdout
      end
    end
  end
end
