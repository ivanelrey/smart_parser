module LogFile
  module Validators
    class WebPageValidator
      REGEX_VALIDATOR = %r{^/\S*$}.freeze

      def valid?(line)
        REGEX_VALIDATOR.match?(line.web_page_string)
      end
    end
  end
end
