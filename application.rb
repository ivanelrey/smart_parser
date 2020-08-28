require './lib/log_file/line'
require './lib/log_file/counter'

class Application
  def run(file_name)
    raise ArgumentError, 'Please provide a file name.' if file_name.nil?
    raise ArgumentError, 'Please provide an existing file.' unless File.exist?(file_name)

    counter = LogFile::Counter.new
    parse_file(file_name, counter)
    output_results(counter)
  end

  private

  def parse_file(file_name, counter)
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

  def output_results(counter)
    puts 'Most visited pages:'
    counter.visits_per_web_page.each do |key, value|
      puts "#{key} -> #{value[:total_visits]}"
    end

    puts 'Most uniq visits:'
    counter.visits_per_web_page.each do |key, value|
      puts "#{key} -> #{value[:ip_list].count}"
    end
  end

  def exit_with_error(error_msg)
    puts error_msg
    exit 1
  end
end
