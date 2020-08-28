require './lib/log_file/line'

class Application
  def run(file_name)
    raise ArgumentError, 'Please provide a file name.' if file_name.nil?
    raise ArgumentError, 'Please provide an existing file.' unless File.exist?(file_name)

    results = Hash.new { |h, k| h[k] = { ip_list: Set.new, total_visits: 0 } }
    parse_file(file_name, results)
    output_results(results)
  end

  private

  def parse_file(file_name, results)
    File.open(file_name).each_with_index do |line, index|
      begin
        log_file_line = LogFile::Line.new(line)
        exit_with_error("Invalid WebPage or IP detected on line: #{index + 1}") unless log_file_line.valid?

        visit = results[log_file_line.web_page_string]
        visit[:ip_list].add(log_file_line.ip_string)
        visit[:total_visits] += 1
      rescue LogFile::UnparsableLineError
        exit_with_error("Unparsable line detected on line: #{index + 1}")
      end
    end
  end

  def output_results(results)
    puts 'Most visited pages:'
    results.each do |key, value|
      puts "#{key} -> #{value[:total_visits]}"
    end

    puts 'Most uniq visits:'
    results.each do |key, value|
      puts "#{key} -> #{value[:ip_list].count}"
    end
  end

  def exit_with_error(error_msg)
    puts error_msg
    exit 1
  end
end
