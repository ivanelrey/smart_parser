require './lib/log_file/validators/ip_validator'
require './lib/log_file/validators/web_page_validator'

module LogFile
  UnparsableLineError = Class.new(StandardError)

  class Line
    LINE_REGEX = /^\s?+(?<web_page>\S+)\s+(?<ip>\S+)/.freeze

    attr_reader :web_page_string, :ip_string

    def initialize(line_string)
      matches = LINE_REGEX.match(line_string)
      raise UnparsableLineError unless matches

      @web_page_string = matches[:web_page]
      @ip_string = matches[:ip]
    end

    def valid?
      validators.all? { |validator| validator.valid?(self) }
    end

    private

    def validators
      [Validators::IpValidator.new, Validators::WebPageValidator.new]
    end
  end
end
