module LogFile
  UnparsableLineError = Class.new(StandardError)

  class Line
    LINE_REGEX = /^(?<web_page>\S+)\s(?<ip>\S+)/.freeze

    attr_reader :web_page_string, :ip_string

    def initialize(line_string)
      matches = LINE_REGEX.match(line_string.strip)
      raise UnparsableLineError unless matches

      @web_page_string = matches[:web_page]
      @ip_string = matches[:ip]
    end
  end
end
