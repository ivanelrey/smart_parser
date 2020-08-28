class Application
  def run(file_name)
    raise ArgumentError, 'Please provide a file name.' if file_name.nil?
    raise ArgumentError, 'Please provide an existing file.' unless File.exist?(file_name)

    lines = []
    File.open(file_name).each do |line|
      lines << line
    end

    output_results(lines)
  end

  private

  def output_results(lines)
    puts 'Most visited pages:'
    lines.each do |_line|
      puts 'line'
    end

    puts 'Most uniq visits:'
    lines.each do |_line|
      puts 'line'
    end
  end
end
