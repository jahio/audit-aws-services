#
# lib/cli.rb -- scaffolding/setup for building the cli with thor
#
require 'thor'

class AwsAudit
  class CLI < Thor

    #
    # class options apply to all the commands within this class.
    #
    class_option :json,    :type => :boolean, :default => false
    class_option :logfile, :type => :string,  :default => nil
    class_option :color,   :type => :boolean, :default => true

    #
    # version - output current version and exit
    #
    desc "version", "output current version of aws-audit and exit"
    def version
      puts AwsAudit::VERSION
    end

    #
    # summary - get current state and print summary data to
    # the terminal screen.
    #
    desc "summary", "gets and prints SUMMARY data from all known AWS services as AWS sees it right now"
    def summary
      puts "TODO: Get stuff, compile summary, print summary"
    end

    #
    # all - same as summary but prints maximum level of detail to the screen
    #
    desc "details", "fetches current state of all known AWS services as AWS sees them right now and returns highly detailed information"
    def details
      puts "TODO: get all the things and put them on the screen in detail-overload mode"
    end

    #
    # validate-credentials -- debug task to help ensure aws-audit sees your credentials
    # and can parse the terraform.tfvars file contents correctly.
    #
    desc "validate-credentials", "debug tool to make sure aws-audit can find and parse your AWS credentials in terraform.tfvars"
    def validate_credentials
      puts "TODO: Write the logic for finding/parsing terraform.tfvars, then trigger it here"
      puts "TODO: Also, only print the first and last 3 characters of sensitive values like tokens/secrets"
      puts "TODO: Show full system path to terraform.tfvars on disk so the user knows it's finding the right one"
    end


  end
end
