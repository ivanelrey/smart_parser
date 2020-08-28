require './lib/log_file/line'
require './lib/log_file/counter'

class Application
  def run(file_name)
    raise ArgumentError, 'Please provide a file name.' if file_name.nil?
    raise ArgumentError, 'Please provide an existing file.' unless File.exist?(file_name)

    counter = LogFile::Counter.new
    parse_file(file_name, counter)

    total_visits = counter.visits_per_web_page.map { |key, value| [key, value[:total_visits]] }.sort_by { |_x, y| -y }
    uniq_visits = counter.visits_per_web_page.map { |key, value| [key, value[:ip_list].count] }.sort_by { |_x, y| -y }
    output_results(total_visits, uniq_visits)
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

  def output_results(total_visits, uniq_visits)
    puts 'Most visited pages:'
    total_visits.each do |web_page, count|
      puts "#{web_page} -> #{count}"
    end

    puts 'Most uniq visits:'
    uniq_visits.each do |web_page, count|
      puts "#{web_page} -> #{count}"
    end
  end

  def exit_with_error(error_msg)
    puts error_msg
    exit 1
  end
end
