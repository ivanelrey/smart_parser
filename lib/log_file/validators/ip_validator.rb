module LogFile
  module Validators
    class IpValidator
      REGEX_VALIDATOR = /^\d+\.\d+\.\d+\.\d+$/.freeze

      def valid?(line)
        REGEX_VALIDATOR.match?(line.ip_string)
      end
    end
  end
end
