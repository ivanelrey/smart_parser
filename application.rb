class Application
  def run(file_name)
    raise ArgumentError, 'Please provide a file name.' if file_name.nil?
  end
end
