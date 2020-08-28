require './lib/log_file/line'
require './lib/log_file/counter'
require './lib/log_file/presenters/counter_presenter'

class Application
  attr_reader :file_name

  def initialize(file_name)
    raise ArgumentError, 'Please provide a file name.' if file_name.nil?
    raise ArgumentError, 'Please provide an existing file.' unless File.exist?(file_name)

    @file_name = file_name
  end

  def run
    counter = LogFile::Counter.new
    parse_file(counter)

    counter_presenter = LogFile::Presenters::CounterPresenter.new(counter)
    output_results(counter_presenter)
  end

  private

  def parse_file(counter)
    File.open(file_name).each_with_index do |line, index|
      begin
        log_file_line = LogFile::Line.new(line)
        exit_with_error("Invalid WebPage or IP detected on line: #{index + 1}") unless log_file_line.valid?

        counter.add_web_page_visit(log_file_line.web_page_string, log_file_line.ip_string)
      rescue LogFile::UnparsableLineError
        exit_with_error("Unparsable line detected on line: #{index + 1}")
      end
    end
  end

  def output_results(counter_presenter)
    puts 'Most visited pages:'
    counter_presenter.most_visited_pages.each do |web_page, count|
      puts "#{web_page} -> #{count}"
    end

    puts "\n"
    puts 'Most uniq visits:'
    counter_presenter.most_uniq_visited_pages.each do |web_page, count|
      puts "#{web_page} -> #{count}"
    end
  end

  def exit_with_error(error_msg)
    puts error_msg
    exit 1
  end
end
