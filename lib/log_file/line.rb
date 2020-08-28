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

    def valid?
      web_page_validator_regex.match?(web_page_string) && ip_validator_regex.match?(ip_string)
    end

    private

    def web_page_validator_regex
      %r{^/\S*$}
    end

    def ip_validator_regex
      /^\d+\.\d+\.\d+\.\d+$/
    end
  end
end
