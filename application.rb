require './lib/log_file/line'

class Application
  def run(file_name)
    raise ArgumentError, 'Please provide a file name.' if file_name.nil?
    raise ArgumentError, 'Please provide an existing file.' unless File.exist?(file_name)

    parsed_lines = []
    parse_file(file_name, parsed_lines)

    output_results(parsed_lines)
  end

  private

  def parse_file(file_name, parsed_lines)
    File.open(file_name).each_with_index do |line, index|
      begin
        log_file_line = LogFile::Line.new(line)
        parsed_lines << [log_file_line.web_page_string, log_file_line.ip_string]
      rescue LogFile::UnparsableLineError
        exit_with_error("Unparsable line detected on line: #{index + 1}")
      end
    end
  end

  def output_results(parsed_lines)
    puts 'Most visited pages:'
    parsed_lines.each do |_line|
      puts 'line'
    end

    puts 'Most uniq visits:'
    parsed_lines.each do |_line|
      puts 'line'
    end
  end

  def exit_with_error(error_msg)
    puts error_msg
    exit 1
  end
end
