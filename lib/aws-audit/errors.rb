#!/usr/bin/env ruby
#
# lib/errors.rb
#
# Class declaration for errors that can be raised/rescued
# during execution of this code.
#

class AwsAudit
  class Errors
    class ConfigurationError < StandardError ; end
    class AwsFail            < StandardError ; end
    class CLIError           < StandardError ; end
  end
end
